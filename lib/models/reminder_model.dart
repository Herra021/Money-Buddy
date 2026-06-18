class ReminderModel {
  final int? id;
  final String title;
  final double? amount;
  final DateTime dueDate;
  final bool isRecurring;
  final String? recurrenceType; // 'daily' | 'weekly' | 'monthly'
  final int? notificationId;
  final bool isPaid;
  final DateTime createdAt;

  const ReminderModel({
    this.id,
    required this.title,
    this.amount,
    required this.dueDate,
    this.isRecurring = false,
    this.recurrenceType,
    this.notificationId,
    this.isPaid = false,
    required this.createdAt,
  });

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: map['amount'] != null ? (map['amount'] as num).toDouble() : null,
      dueDate: DateTime.parse(map['due_date'] as String),
      isRecurring: (map['is_recurring'] as int) == 1,
      recurrenceType: map['recurrence_type'] as String?,
      notificationId: map['notification_id'] as int?,
      isPaid: (map['is_paid'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'title': title,
        'amount': amount,
        'due_date': dueDate.toIso8601String(),
        'is_recurring': isRecurring ? 1 : 0,
        'recurrence_type': recurrenceType,
        'notification_id': notificationId,
        'is_paid': isPaid ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
      };

  bool get isOverdue => dueDate.isBefore(DateTime.now()) && !isPaid;
  bool get isDueToday {
    final now = DateTime.now();
    return dueDate.year == now.year && dueDate.month == now.month && dueDate.day == now.day;
  }
  bool get isUpcoming => dueDate.isAfter(DateTime.now()) && !isPaid;

  ReminderModel copyWith({bool? isPaid, DateTime? dueDate, int? notificationId}) {
    return ReminderModel(
      id: id,
      title: title,
      amount: amount,
      dueDate: dueDate ?? this.dueDate,
      isRecurring: isRecurring,
      recurrenceType: recurrenceType,
      notificationId: notificationId ?? this.notificationId,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt,
    );
  }
}
