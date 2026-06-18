import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../models/reminder_model.dart';
import '../../providers/reminder_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/empty_state_widget.dart';
import '../../l10n/app_localizations.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(reminderProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(l10n.reminders),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddReminderSheet(context, ref),
          ),
        ],
      ),
      body: remindersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (reminders) {
          if (reminders.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.notifications_none_outlined,
              title: l10n.noRemindersYet,
              subtitle: l10n.addRemindersHelp,
              actionLabel: l10n.addReminder,
              onAction: () => _showAddReminderSheet(context, ref),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reminders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (ctx, i) => _ReminderCard(reminder: reminders[i]),
          );
        },
      ),
    );
  }

  void _showAddReminderSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => _AddReminderSheet(ref: ref),
    );
  }
}

class _ReminderCard extends ConsumerWidget {
  final ReminderModel reminder;
  const _ReminderCard({required this.reminder});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = reminder.isPaid
        ? AppColors.income
        : reminder.isOverdue
            ? AppColors.expense
            : reminder.isDueToday
                ? const Color(0xFFF4511E)
                : AppColors.primaryContainer;

    return Dismissible(
      key: Key('reminder_${reminder.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.errorContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.error),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.deleteReminder),
            content: Text(l10n.areYouSure),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
              TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.delete, style: const TextStyle(color: AppColors.error))),
            ],
          ),
        );
      },
      onDismissed: (_) => ref.read(reminderProvider.notifier).delete(reminder.id!, reminder.notificationId),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: reminder.isOverdue && !reminder.isPaid ? AppColors.expense.withOpacity(0.3) : AppColors.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            // Timeline dot
            Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    reminder.isPaid
                        ? Icons.check_circle
                        : reminder.isOverdue
                            ? Icons.error_outline
                            : Icons.notifications_active_outlined,
                    color: statusColor,
                    size: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.onSurface),
                  ),
                  const SizedBox(height: 2),
                  if (reminder.amount != null)
                    Text(
                      '${ref.watch(settingsProvider).currencySymbol}${reminder.amount!.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: statusColor),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d, y').format(reminder.dueDate),
                        style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.w500),
                      ),
                      if (reminder.isOverdue && !reminder.isPaid) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.expense.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(l10n.overdueTag, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.expense)),
                        ),
                      ],
                      if (reminder.isDueToday && !reminder.isPaid) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4511E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(l10n.todayTag, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFFF4511E))),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (!reminder.isPaid)
              TextButton(
                onPressed: () => ref.read(reminderProvider.notifier).markAsPaid(reminder.id!, reminder.notificationId),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.income,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                child: Text(l10n.done),
              )
            else
              const Icon(Icons.check_circle, color: AppColors.income, size: 20),
          ],
        ),
      ),
    );
  }
}

class _AddReminderSheet extends StatefulWidget {
  final WidgetRef ref;
  const _AddReminderSheet({required this.ref});

  @override
  State<_AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<_AddReminderSheet> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  bool _isSaving = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_titleCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseEnterTitle)),
      );
      return;
    }

    setState(() => _isSaving = true);
    final reminder = ReminderModel(
      title: _titleCtrl.text.trim(),
      amount: _amountCtrl.text.isNotEmpty ? double.tryParse(_amountCtrl.text) : null,
      dueDate: _dueDate,
      createdAt: DateTime.now(),
    );
    final currencySymbol = widget.ref.read(settingsProvider).currencySymbol;
    await widget.ref.read(reminderProvider.notifier).add(reminder, currencySymbol);
    setState(() => _isSaving = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final keyboardH = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 24 + keyboardH),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColors.outlineVariant, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 20),
          Text(l10n.newReminder,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
          const SizedBox(height: 20),
          TextField(
            controller: _titleCtrl,
            decoration: InputDecoration(labelText: l10n.reminderTitle, prefixIcon: const Icon(Icons.label_outline)),
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.amountOptional, prefixIcon: const Icon(Icons.attach_money)),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _dueDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );
              if (picked != null) setState(() => _dueDate = picked);
            },
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: InputDecoration(labelText: l10n.dueDate, prefixIcon: const Icon(Icons.event)),
              child: Text(DateFormat('EEE, MMM d, y').format(_dueDate),
                  style: const TextStyle(fontSize: 14, color: AppColors.onSurface)),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: _isSaving ? null : _save,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              ),
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                  : Text(l10n.saveReminder, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
