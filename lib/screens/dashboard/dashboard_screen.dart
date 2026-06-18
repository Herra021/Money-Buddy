import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/router/app_router.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/transaction_tile.dart';
import '../../widgets/empty_state_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String _userName = 'Friend';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _userName = prefs.getString('user_name') ?? 'Friend');
  }

  String _greeting(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning(_userName);
    if (hour < 17) return l10n.goodAfternoon(_userName);
    return l10n.goodEvening(_userName);
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final l10n = AppLocalizations.of(context)!;
    final currencySymbol = ref.watch(settingsProvider).currencySymbol;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primaryContainer,
        onRefresh: () async {
          ref.invalidate(dashboardProvider);
        },
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              backgroundColor: AppColors.background,
              floating: true,
              snap: true,
              elevation: 0,
              expandedHeight: 70,
              title: Text(
                _greeting(context),
                style: const TextStyle(
                  
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.settings_outlined, color: AppColors.primaryContainer, size: 20),
                  ),
                  onPressed: () => context.push(AppRoutes.settings),
                ),
                const SizedBox(width: 8),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  dashboardAsync.when(
                    loading: () => const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (e, _) => Center(child: Text('Error: $e')),
                    data: (data) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BalanceCard(
                          netBalance: data.netBalance,
                          income: data.totalIncome,
                          expense: data.totalExpense,
                          greeting: DateFormat('MMMM y').format(DateTime.now()),
                          currencySymbol: currencySymbol,
                        ),
                        const SizedBox(height: 24),

                        // Chart section
                        _SectionHeader(
                          title: l10n.last6Months,
                          subtitle: l10n.incomeVsExpense,
                        ),
                        const SizedBox(height: 12),
                        _ChartCard(chartData: data.chartData),
                        const SizedBox(height: 24),

                        // Recent transactions
                        _SectionHeader(
                          title: l10n.recentTransactions,
                          subtitle: l10n.thisMonth,
                          action: TextButton(
                            onPressed: () => context.go(AppRoutes.transactions),
                            child: Text(l10n.seeAll,
                                style: const TextStyle(fontSize: 13, color: AppColors.primaryContainer)),
                          ),
                        ),
                        const SizedBox(height: 12),

                        if (data.recentTransactions.isEmpty)
                          EmptyStateWidget(
                            icon: Icons.receipt_long_outlined,
                            title: l10n.noTransactionsYet,
                            subtitle: l10n.tapPlusToAdd,
                          )
                        else
                          ...data.recentTransactions.map(
                            (txn) => TransactionTile(
                              transaction: txn,
                              currencySymbol: currencySymbol,
                              onDelete: () {
                                ref.read(transactionProvider.notifier).delete(txn.id!);
                              },
                            ),
                          ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? action;

  const _SectionHeader({required this.title, required this.subtitle, this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class _ChartCard extends StatelessWidget {
  final List<Map<String, dynamic>> chartData;
  const _ChartCard({required this.chartData});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (chartData.isEmpty) {
      return Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Center(child: Text(l10n.noChartDataYet, style: const TextStyle(color: AppColors.outline))),
      );
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          // Legend
          Row(
            children: [
              _Legend(color: AppColors.income, label: l10n.income),
              const SizedBox(width: 16),
              _Legend(color: AppColors.expense, label: l10n.expense),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: chartData.fold<double>(0, (max, d) {
                  final m = [d['income'] as double, d['expense'] as double].reduce((a, b) => a > b ? a : b);
                  return m > max ? m * 1.3 : max * 1.3;
                }),
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= chartData.length) return const SizedBox();
                        final month = chartData[i]['month'] as DateTime;
                        return Text(
                          DateFormat('MMM').format(month),
                          style: const TextStyle(fontSize: 10, color: AppColors.outline),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => const FlLine(
                    color: AppColors.outlineVariant,
                    strokeWidth: 0.5,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: chartData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: (entry.value['income'] as double),
                        color: AppColors.income.withOpacity(0.8),
                        width: 10,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                      BarChartRodData(
                        toY: (entry.value['expense'] as double),
                        color: AppColors.expense.withOpacity(0.8),
                        width: 10,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}
