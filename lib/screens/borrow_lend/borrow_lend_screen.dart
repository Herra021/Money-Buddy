import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../core/router/app_router.dart';
import '../../models/borrow_lend_model.dart';
import '../../providers/borrow_lend_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/empty_state_widget.dart';
import '../../l10n/app_localizations.dart';

class BorrowLendScreen extends ConsumerStatefulWidget {
  const BorrowLendScreen({super.key});

  @override
  ConsumerState<BorrowLendScreen> createState() => _BorrowLendScreenState();
}

class _BorrowLendScreenState extends ConsumerState<BorrowLendScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lendList = ref.watch(lendListProvider);
    final borrowList = ref.watch(borrowListProvider);
    final currencySymbol = ref.watch(settingsProvider).currencySymbol;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(l10n.borrowLend),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.onSurfaceVariant,
              labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.north_east, size: 14),
                      const SizedBox(width: 4),
                      Text('${l10n.lentTab} (${lendList.length})'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.south_west, size: 14),
                      const SizedBox(width: 4),
                      Text('${l10n.borrowedTab} (${borrowList.length})'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/add-borrow-lend'),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BorrowLendList(items: lendList, type: 'lend', currencySymbol: currencySymbol),
          _BorrowLendList(items: borrowList, type: 'borrow', currencySymbol: currencySymbol),
        ],
      ),
    );
  }
}

class _BorrowLendList extends ConsumerWidget {
  final List<BorrowLendModel> items;
  final String type;
  final String currencySymbol;

  const _BorrowLendList({required this.items, required this.type, required this.currencySymbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    if (items.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.handshake_outlined,
        title: type == 'lend' ? l10n.noMoneyLentYet : l10n.noBorrowedMoney,
        subtitle: type == 'lend'
            ? l10n.addLentRecords
            : l10n.addBorrowedRecords,
        actionLabel: l10n.addRecord,
        onAction: () => context.push('/add-borrow-lend'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) => _BorrowLendCard(item: items[i], currencySymbol: currencySymbol),
    );
  }
}

class _BorrowLendCard extends ConsumerWidget {
  final BorrowLendModel item;
  final String currencySymbol;
  const _BorrowLendCard({required this.item, required this.currencySymbol});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isLend = item.isLend;
    final color = isLend ? AppColors.lend : AppColors.borrow;
    final statusColor = item.isPaid
        ? AppColors.income
        : item.isOverdue
            ? AppColors.expense
            : AppColors.outline;
    final statusLabel = item.isPaid ? l10n.paid : item.isOverdue ? l10n.overdue : l10n.pending;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: item.isOverdue && !item.isPaid ? AppColors.expense.withOpacity(0.3) : AppColors.outlineVariant,
          width: item.isOverdue && !item.isPaid ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    item.personName[0].toUpperCase(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.personName,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.onSurface),
                    ),
                    if (item.note != null && item.note!.isNotEmpty)
                      Text(item.note!, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isLend ? '+' : '-'}$currencySymbol${item.amount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (item.dueDate != null) ...[
            const SizedBox(height: 12),
            Container(height: 1, color: AppColors.outlineVariant),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14, color: item.isOverdue && !item.isPaid ? AppColors.expense : AppColors.outline),
                const SizedBox(width: 6),
                Text(
                  '${l10n.due} ${DateFormat('MMM d, y').format(item.dueDate!)}',
                  style: TextStyle(
                    
                    fontSize: 12,
                    color: item.isOverdue && !item.isPaid ? AppColors.expense : AppColors.outline,
                    fontWeight: item.isOverdue && !item.isPaid ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const Spacer(),
                if (!item.isPaid) ...[
                  TextButton.icon(
                    onPressed: () => ref.read(borrowLendProvider.notifier).markAsPaid(item.id!),
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label: Text(l10n.markPaid),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.income,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
