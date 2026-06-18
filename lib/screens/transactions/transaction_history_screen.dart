import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../models/transaction_model.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/transaction_tile.dart';
import '../../widgets/empty_state_widget.dart';
import '../../l10n/app_localizations.dart';
import '../../core/utils/localization_helper.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  ConsumerState<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends ConsumerState<TransactionHistoryScreen> {
  final _searchCtrl = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionAsync = ref.watch(transactionProvider);
    final currencySymbol = ref.watch(settingsProvider).currencySymbol;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.transactionHistory),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (q) {
                ref.read(transactionProvider.notifier).applyFilter(
                      TransactionFilter(type: _selectedFilter, searchQuery: q),
                    );
              },
              decoration: InputDecoration(
                hintText: l10n.searchTransactions,
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchCtrl.clear();
                          ref.read(transactionProvider.notifier).applyFilter(
                                TransactionFilter(type: _selectedFilter),
                              );
                        },
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(label: l10n.all, isSelected: _selectedFilter == 'all', onTap: () => _setFilter('all')),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.income,
                  isSelected: _selectedFilter == 'income',
                  onTap: () => _setFilter('income'),
                  color: AppColors.income,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.expense,
                  isSelected: _selectedFilter == 'expense',
                  onTap: () => _setFilter('expense'),
                  color: AppColors.expense,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // List
          Expanded(
            child: transactionAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (txns) {
                if (txns.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.receipt_long_outlined,
                    title: l10n.noTransactionsFound,
                    subtitle: l10n.adjustFilterOrSearch,
                  );
                }
                // Group by date
                final grouped = <String, List<TransactionModel>>{};
                for (final txn in txns) {
                  final key = DateFormat('EEEE, MMM d').format(txn.date);
                  grouped.putIfAbsent(key, () => []).add(txn);
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: grouped.length,
                  itemBuilder: (ctx, i) {
                    final dateKey = grouped.keys.elementAt(i);
                    final items = grouped[dateKey]!;
                    final dayTotal = items.fold<double>(
                      0,
                      (sum, t) => t.isExpense ? sum - t.amount : sum + t.amount,
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateKey,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '${dayTotal >= 0 ? '+' : ''}$currencySymbol${dayTotal.abs().toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: dayTotal >= 0 ? AppColors.income : AppColors.expense,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...items.map(
                          (txn) => _TxnTile(
                            transaction: txn,
                            currencySymbol: currencySymbol,
                            onDelete: () => ref.read(transactionProvider.notifier).delete(txn.id!),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setFilter(String filter) {
    setState(() => _selectedFilter = filter);
    ref.read(transactionProvider.notifier).applyFilter(
          TransactionFilter(type: filter, searchQuery: _searchCtrl.text),
        );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  const _FilterChip({required this.label, required this.isSelected, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final active = color ?? AppColors.primaryContainer;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? active.withOpacity(0.12) : AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: isSelected ? active : AppColors.outlineVariant),
        ),
        child: Text(
          label,
          style: TextStyle(
            
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? active : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _TxnTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onDelete;
  final String currencySymbol;

  const _TxnTile({required this.transaction, required this.onDelete, required this.currencySymbol});

  @override
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorHex = transaction.categoryColor.replaceFirst('#', '');
    final color = Color(int.parse('FF$colorHex', radix: 16));

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
      confirmDismiss: (_) async => await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.deleteTransaction),
          content: Text(l10n.areYouSure),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
            TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.delete, style: const TextStyle(color: AppColors.error))),
          ],
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
              child: Icon(_iconFor(transaction.categoryIcon), color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getLocalizedCategory(context, transaction.categoryName),
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  if (transaction.note != null && transaction.note!.isNotEmpty)
                    Text(transaction.note!,
                        style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Text(
          // Handled inside TransactionTile now, but keeping this simple Tile for now if used.
              '${transaction.isExpense ? '-' : '+'}$currencySymbol${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: transaction.isExpense ? AppColors.expense : AppColors.income,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String name) {
    const m = {
      'restaurant': Icons.restaurant,
      'shopping_bag': Icons.shopping_bag,
      'directions_car': Icons.directions_car,
      'movie': Icons.movie,
      'medical_services': Icons.medical_services,
      'receipt_long': Icons.receipt_long,
      'school': Icons.school,
      'flight': Icons.flight,
      'local_grocery_store': Icons.local_grocery_store,
      'payments': Icons.payments,
      'laptop': Icons.laptop,
      'trending_up': Icons.trending_up,
      'card_giftcard': Icons.card_giftcard,
    };
    return m[name] ?? Icons.category;
  }
}
