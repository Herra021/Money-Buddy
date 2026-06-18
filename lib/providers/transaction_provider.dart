import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/database/database_helper.dart';
import '../models/transaction_model.dart';
import '../models/category_model.dart';

// ── Database provider ─────────────────────────────────────────────────────

final dbProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper());

// ── Categories ────────────────────────────────────────────────────────────

final categoriesProvider = FutureProvider.family<List<CategoryModel>, String>((ref, type) async {
  final db = ref.read(dbProvider);
  final maps = await db.getCategories(type: type);
  return maps.map((m) => CategoryModel.fromMap(m)).toList();
});

// ── Transactions ──────────────────────────────────────────────────────────

class TransactionFilter {
  final String type; // 'all' | 'expense' | 'income'
  final String searchQuery;
  const TransactionFilter({this.type = 'all', this.searchQuery = ''});

  TransactionFilter copyWith({String? type, String? searchQuery}) => TransactionFilter(
        type: type ?? this.type,
        searchQuery: searchQuery ?? this.searchQuery,
      );
}

class TransactionNotifier extends StateNotifier<AsyncValue<List<TransactionModel>>> {
  final DatabaseHelper _db;
  TransactionFilter _filter = const TransactionFilter();

  TransactionNotifier(this._db) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final maps = await _db.getTransactions(
        type: _filter.type == 'all' ? null : _filter.type,
        searchQuery: _filter.searchQuery.isNotEmpty ? _filter.searchQuery : null,
      );
      state = AsyncValue.data(maps.map(TransactionModel.fromMap).toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(TransactionModel transaction) async {
    await _db.insertTransaction(transaction.toMap());
    await _load();
  }

  Future<void> delete(int id) async {
    await _db.deleteTransaction(id);
    await _load();
  }

  void applyFilter(TransactionFilter filter) {
    _filter = filter;
    _load();
  }

  void refresh() => _load();
}

final transactionProvider = StateNotifierProvider<TransactionNotifier, AsyncValue<List<TransactionModel>>>(
  (ref) => TransactionNotifier(ref.read(dbProvider)),
);

// ── Dashboard data ─────────────────────────────────────────────────────────

class DashboardData {
  final double totalIncome;
  final double totalExpense;
  final double netBalance;
  final List<TransactionModel> recentTransactions;
  final List<Map<String, dynamic>> chartData;

  const DashboardData({
    required this.totalIncome,
    required this.totalExpense,
    required this.netBalance,
    required this.recentTransactions,
    required this.chartData,
  });
}

final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  // Rebuild when transactions change
  ref.watch(transactionProvider);

  final db = ref.read(dbProvider);
  final now = DateTime.now();
  final monthlyTotals = await db.getMonthlyTotals(now);
  final chartData = await db.getLast6MonthsData();
  final recentMaps = await db.getTransactions(limit: 5);

  final income = monthlyTotals['income'] ?? 0.0;
  final expense = monthlyTotals['expense'] ?? 0.0;

  return DashboardData(
    totalIncome: income,
    totalExpense: expense,
    netBalance: income - expense,
    recentTransactions: recentMaps.map(TransactionModel.fromMap).toList(),
    chartData: chartData,
  );
});
