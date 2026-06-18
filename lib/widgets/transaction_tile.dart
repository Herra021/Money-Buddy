import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/transaction_model.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../core/utils/localization_helper.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onDelete;
  final String currencySymbol;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.onDelete,
    this.currencySymbol = '₹',
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorHex = transaction.categoryColor.replaceFirst('#', '');
    final color = Color(int.parse('FF$colorHex', radix: 16));
    final isExpense = transaction.isExpense;

    return Dismissible(
      key: Key('txn_${transaction.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.error),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.deleteTransaction),
            content: Text(l10n.areYouSureDeleteTxn),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.delete, style: const TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete?.call(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant, width: 1),
        ),
        child: Row(
          children: [
            // Category icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _iconWidget(transaction.categoryIcon, color),
            ),
            const SizedBox(width: 12),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getLocalizedCategory(context, transaction.categoryName),
                    style: const TextStyle(
                      
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  if (transaction.note != null && transaction.note!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      transaction.note!,
                      style: const TextStyle(
                        
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('MMM d, y').format(transaction.date),
                    style: const TextStyle(
                      
                      fontSize: 11,
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              '${isExpense ? '-' : '+'}$currencySymbol${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isExpense ? AppColors.expense : AppColors.income,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWidget(String iconName, Color color) {
    final iconMap = <String, IconData>{
      'restaurant': Icons.restaurant,
      'shopping_bag': Icons.shopping_bag,
      'directions_car': Icons.directions_car,
      'movie': Icons.movie,
      'medical_services': Icons.medical_services,
      'receipt_long': Icons.receipt_long,
      'school': Icons.school,
      'flight': Icons.flight,
      'local_grocery_store': Icons.local_grocery_store,
      'more_horiz': Icons.more_horiz,
      'payments': Icons.payments,
      'laptop': Icons.laptop,
      'trending_up': Icons.trending_up,
      'card_giftcard': Icons.card_giftcard,
    };
    return Icon(iconMap[iconName] ?? Icons.category, color: color, size: 22);
  }
}
