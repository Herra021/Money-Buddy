class TransactionModel {
  final int? id;
  final String type; // 'expense' | 'income'
  final double amount;
  final int? categoryId;
  final String categoryName;
  final String categoryIcon;
  final String categoryColor;
  final String? note;
  final DateTime date;
  final DateTime createdAt;

  const TransactionModel({
    this.id,
    required this.type,
    required this.amount,
    this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
    this.note,
    required this.date,
    required this.createdAt,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      type: map['type'] as String,
      amount: (map['amount'] as num).toDouble(),
      categoryId: map['category_id'] as int?,
      categoryName: map['category_name'] as String? ?? 'Other',
      categoryIcon: map['category_icon'] as String? ?? 'more_horiz',
      categoryColor: map['category_color'] as String? ?? '#757575',
      note: map['note'] as String?,
      date: DateTime.parse(map['date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'type': type,
        'amount': amount,
        'category_id': categoryId,
        'category_name': categoryName,
        'category_icon': categoryIcon,
        'category_color': categoryColor,
        'note': note,
        'date': date.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      };

  bool get isExpense => type == 'expense';
  bool get isIncome => type == 'income';

  TransactionModel copyWith({
    int? id,
    String? type,
    double? amount,
    String? categoryName,
    String? categoryIcon,
    String? categoryColor,
    String? note,
    DateTime? date,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      categoryId: categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      categoryColor: categoryColor ?? this.categoryColor,
      note: note ?? this.note,
      date: date ?? this.date,
      createdAt: createdAt,
    );
  }
}
