import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/database/database_helper.dart';
import '../core/notifications/notification_service.dart';
import '../models/reminder_model.dart';
import 'transaction_provider.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

class ReminderNotifier extends StateNotifier<AsyncValue<List<ReminderModel>>> {
  final DatabaseHelper _db;
  final NotificationService _notifications;

  ReminderNotifier(this._db, this._notifications) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final maps = await _db.getReminders();
      state = AsyncValue.data(maps.map(ReminderModel.fromMap).toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(ReminderModel reminder, String currencySymbol) async {
    final notifId = DateTime.now().millisecondsSinceEpoch % 100000;
    final updated = reminder.copyWith(notificationId: notifId);

    await _db.insertReminder(updated.toMap());

    // Schedule notification 1 day before and on the day
    if (!reminder.dueDate.isBefore(DateTime.now())) {
      await _notifications.scheduleReminder(
        id: notifId,
        title: '💰 Reminder: ${reminder.title}',
        body: reminder.amount != null
            ? 'Payment of $currencySymbol${reminder.amount!.toStringAsFixed(2)} is due today!'
            : 'Your reminder "${reminder.title}" is due today!',
        scheduledDate: DateTime(
          reminder.dueDate.year,
          reminder.dueDate.month,
          reminder.dueDate.day,
          9, 0, // 9 AM on due day
        ),
      );
    }
    await _load();
  }

  Future<void> markAsPaid(int id, int? notificationId) async {
    await _db.updateReminder(id, {'is_paid': 1});
    if (notificationId != null) {
      await _notifications.cancelNotification(notificationId);
    }
    await _load();
  }

  Future<void> delete(int id, int? notificationId) async {
    await _db.deleteReminder(id);
    if (notificationId != null) {
      await _notifications.cancelNotification(notificationId);
    }
    await _load();
  }

  void refresh() => _load();
}

final reminderProvider = StateNotifierProvider<ReminderNotifier, AsyncValue<List<ReminderModel>>>(
  (ref) => ReminderNotifier(ref.read(dbProvider), ref.read(notificationServiceProvider)),
);
