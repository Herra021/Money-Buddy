import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'money_buddy.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon TEXT NOT NULL,
        color_hex TEXT NOT NULL,
        type TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        category_id INTEGER,
        category_name TEXT,
        category_icon TEXT,
        category_color TEXT,
        note TEXT,
        date TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE borrow_lend (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        person_name TEXT NOT NULL,
        amount REAL NOT NULL,
        note TEXT,
        due_date TEXT,
        is_paid INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL,
        due_date TEXT NOT NULL,
        is_recurring INTEGER NOT NULL DEFAULT 0,
        recurrence_type TEXT,
        notification_id INTEGER,
        is_paid INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    // Seed default categories
    await _seedCategories(db);
  }

  Future<void> _seedCategories(Database db) async {
    final expenseCategories = [
      {'name': 'Food & Dining', 'icon': 'restaurant', 'color_hex': '#E53935', 'type': 'expense'},
      {'name': 'Shopping', 'icon': 'shopping_bag', 'color_hex': '#8E24AA', 'type': 'expense'},
      {'name': 'Transport', 'icon': 'directions_car', 'color_hex': '#1E88E5', 'type': 'expense'},
      {'name': 'Entertainment', 'icon': 'movie', 'color_hex': '#F4511E', 'type': 'expense'},
      {'name': 'Health', 'icon': 'medical_services', 'color_hex': '#00897B', 'type': 'expense'},
      {'name': 'Bills', 'icon': 'receipt_long', 'color_hex': '#6D4C41', 'type': 'expense'},
      {'name': 'Education', 'icon': 'school', 'color_hex': '#3949AB', 'type': 'expense'},
      {'name': 'Travel', 'icon': 'flight', 'color_hex': '#039BE5', 'type': 'expense'},
      {'name': 'Groceries', 'icon': 'local_grocery_store', 'color_hex': '#43A047', 'type': 'expense'},
      {'name': 'Other', 'icon': 'more_horiz', 'color_hex': '#757575', 'type': 'expense'},
    ];

    final incomeCategories = [
      {'name': 'Salary', 'icon': 'payments', 'color_hex': '#0A6640', 'type': 'income'},
      {'name': 'Freelance', 'icon': 'laptop', 'color_hex': '#1E88E5', 'type': 'income'},
      {'name': 'Investment', 'icon': 'trending_up', 'color_hex': '#8E24AA', 'type': 'income'},
      {'name': 'Gift', 'icon': 'card_giftcard', 'color_hex': '#F4511E', 'type': 'income'},
      {'name': 'Other', 'icon': 'more_horiz', 'color_hex': '#757575', 'type': 'income'},
    ];

    for (final cat in [...expenseCategories, ...incomeCategories]) {
      await db.insert('categories', cat);
    }
  }

  // ── TRANSACTIONS ──────────────────────────────────────────────────────────

  Future<int> insertTransaction(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('transactions', data);
  }

  Future<List<Map<String, dynamic>>> getTransactions({String? type, String? searchQuery, int? limit}) async {
    final db = await database;
    String where = '';
    List<dynamic> whereArgs = [];

    if (type != null && type != 'all') {
      where = 'type = ?';
      whereArgs = [type];
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final q = '%$searchQuery%';
      if (where.isNotEmpty) {
        where += ' AND (note LIKE ? OR category_name LIKE ?)';
        whereArgs.addAll([q, q]);
      } else {
        where = '(note LIKE ? OR category_name LIKE ?)';
        whereArgs = [q, q];
      }
    }

    return await db.query(
      'transactions',
      where: where.isNotEmpty ? where : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'date DESC, created_at DESC',
      limit: limit,
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<String, double>> getMonthlyTotals(DateTime month) async {
    final db = await database;
    final startOfMonth = DateTime(month.year, month.month, 1).toIso8601String();
    final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59).toIso8601String();

    final results = await db.rawQuery('''
      SELECT type, SUM(amount) as total
      FROM transactions
      WHERE date >= ? AND date <= ?
      GROUP BY type
    ''', [startOfMonth, endOfMonth]);

    double income = 0, expense = 0;
    for (final row in results) {
      if (row['type'] == 'income') income = (row['total'] as num).toDouble();
      if (row['type'] == 'expense') expense = (row['total'] as num).toDouble();
    }
    return {'income': income, 'expense': expense};
  }

  Future<List<Map<String, dynamic>>> getLast6MonthsData() async {
    final List<Map<String, dynamic>> result = [];

    for (int i = 5; i >= 0; i--) {
      final month = DateTime.now();
      final target = DateTime(month.year, month.month - i, 1);
      final totals = await getMonthlyTotals(target);
      result.add({
        'month': target,
        'income': totals['income'] ?? 0.0,
        'expense': totals['expense'] ?? 0.0,
      });
    }
    return result;
  }

  // ── BORROW / LEND ─────────────────────────────────────────────────────────

  Future<int> insertBorrowLend(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('borrow_lend', data);
  }

  Future<List<Map<String, dynamic>>> getBorrowLend({String? type}) async {
    final db = await database;
    return await db.query(
      'borrow_lend',
      where: type != null ? 'type = ?' : null,
      whereArgs: type != null ? [type] : null,
      orderBy: 'due_date ASC, created_at DESC',
    );
  }

  Future<int> updateBorrowLend(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('borrow_lend', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBorrowLend(int id) async {
    final db = await database;
    return await db.delete('borrow_lend', where: 'id = ?', whereArgs: [id]);
  }

  // ── REMINDERS ─────────────────────────────────────────────────────────────

  Future<int> insertReminder(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('reminders', data);
  }

  Future<List<Map<String, dynamic>>> getReminders() async {
    final db = await database;
    return await db.query('reminders', orderBy: 'due_date ASC');
  }

  Future<int> updateReminder(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('reminders', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteReminder(int id) async {
    final db = await database;
    return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }

  // ── CATEGORIES ────────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> getCategories({String? type}) async {
    final db = await database;
    return await db.query(
      'categories',
      where: type != null ? 'type = ?' : null,
      whereArgs: type != null ? [type] : null,
      orderBy: 'name ASC',
    );
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('transactions');
      await txn.delete('borrow_lend');
      await txn.delete('reminders');
    });
  }
}
