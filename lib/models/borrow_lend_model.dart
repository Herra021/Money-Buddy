class BorrowLendModel {
  final int? id;
  final String type; // 'lend' | 'borrow'
  final String personName;
  final double amount;
  final String? note;
  final DateTime? dueDate;
  final bool isPaid;
  final DateTime createdAt;

  const BorrowLendModel({
    this.id,
    required this.type,
    required this.personName,
    required this.amount,
    this.note,
    this.dueDate,
    this.isPaid = false,
    required this.createdAt,
  });

  factory BorrowLendModel.fromMap(Map<String, dynamic> map) {
    return BorrowLendModel(
      id: map['id'] as int?,
      type: map['type'] as String,
      personName: map['person_name'] as String,
      amount: (map['amount'] as num).toDouble(),
      note: map['note'] as String?,
      dueDate: map['due_date'] != null ? DateTime.parse(map['due_date'] as String) : null,
      isPaid: (map['is_paid'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'type': type,
        'person_name': personName,
        'amount': amount,
        'note': note,
        'due_date': dueDate?.toIso8601String(),
        'is_paid': isPaid ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
      };

  bool get isLend => type == 'lend';
  bool get isBorrow => type == 'borrow';

  bool get isOverdue {
    if (dueDate == null || isPaid) return false;
    return dueDate!.isBefore(DateTime.now());
  }

  BorrowLendModel copyWith({bool? isPaid}) {
    return BorrowLendModel(
      id: id,
      type: type,
      personName: personName,
      amount: amount,
      note: note,
      dueDate: dueDate,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt,
    );
  }
}
