import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../models/borrow_lend_model.dart';
import '../../providers/borrow_lend_provider.dart';
import '../../providers/settings_provider.dart';
import '../../l10n/app_localizations.dart';

class AddBorrowLendScreen extends ConsumerStatefulWidget {
  const AddBorrowLendScreen({super.key});

  @override
  ConsumerState<AddBorrowLendScreen> createState() => _AddBorrowLendScreenState();
}

class _AddBorrowLendScreenState extends ConsumerState<AddBorrowLendScreen> {
  final _personCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String _type = 'lend';
  DateTime? _dueDate;
  bool _isSaving = false;

  @override
  void dispose() {
    _personCtrl.dispose();
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (_personCtrl.text.isEmpty || _amountCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.personNameAndAmountRequired)),
      );
      return;
    }
    final amount = double.tryParse(_amountCtrl.text);
    if (amount == null || amount <= 0) return;

    setState(() => _isSaving = true);
    final item = BorrowLendModel(
      type: _type,
      personName: _personCtrl.text.trim(),
      amount: amount,
      note: _noteCtrl.text.trim().isNotEmpty ? _noteCtrl.text.trim() : null,
      dueDate: _dueDate,
      createdAt: DateTime.now(),
    );
    await ref.read(borrowLendProvider.notifier).add(item);
    setState(() => _isSaving = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.recordAdded), backgroundColor: AppColors.income),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLend = _type == 'lend';
    final color = isLend ? AppColors.lend : AppColors.borrow;
    final currencySymbol = ref.watch(settingsProvider).currencySymbol;

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.addBorrowLend),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type selector
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _type = 'lend'),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: !isLend ? Colors.transparent : AppColors.lend,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            l10n.iLent,
                            style: TextStyle(
                              
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isLend ? Colors.white : AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _type = 'borrow'),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isLend ? Colors.transparent : AppColors.borrow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            l10n.iBorrowed,
                            style: TextStyle(
                              
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: !isLend ? Colors.white : AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Amount card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLend ? l10n.amountLent : l10n.amountBorrowed,
                    style: TextStyle(fontSize: 13, color: color.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(currencySymbol, style: TextStyle(fontSize: 24, color: color.withOpacity(0.6))),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _amountCtrl,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: color),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            hintStyle: TextStyle(color: color.withOpacity(0.3), fontSize: 36, fontWeight: FontWeight.w700),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                          ),
                          cursorColor: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _personCtrl,
              decoration: InputDecoration(
                labelText: isLend ? l10n.lentToPerson : l10n.borrowedFromPerson,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteCtrl,
              decoration: InputDecoration(
                labelText: l10n.noteOptional,
                prefixIcon: const Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 16),

            // Due date
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 7)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => _dueDate = picked);
              },
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: l10n.dueDateOptional,
                  prefixIcon: const Icon(Icons.event),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dueDate != null ? DateFormat('EEE, MMM d, y').format(_dueDate!) : l10n.tapToSetDueDate,
                      style: TextStyle(
                        
                        fontSize: 14,
                        color: _dueDate != null ? AppColors.onSurface : AppColors.outline,
                      ),
                    ),
                    if (_dueDate != null)
                      GestureDetector(
                        onTap: () => setState(() => _dueDate = null),
                        child: const Icon(Icons.close, size: 16, color: AppColors.outline),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _isSaving ? null : _save,
                style: FilledButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : Text(
                        isLend ? l10n.saveLendRecord : l10n.saveBorrowRecord,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
