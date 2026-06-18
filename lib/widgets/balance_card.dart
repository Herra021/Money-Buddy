import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

import '../l10n/app_localizations.dart';

class BalanceCard extends StatelessWidget {
  final double netBalance;
  final double income;
  final double expense;
  final String greeting;
  final String currencySymbol;

  const BalanceCard({
    super.key,
    required this.netBalance,
    required this.income,
    required this.expense,
    required this.greeting,
    this.currencySymbol = '₹',
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryContainer, Color(0xFF1565C0), AppColors.secondaryContainer],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryContainer.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: const TextStyle(
              
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatAmount(netBalance),
            style: const TextStyle(
              
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.netBalanceThisMonth,
            style: const TextStyle(
              
              fontSize: 12,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.15),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatChip(
                  label: l10n.income,
                  amount: income,
                  icon: Icons.arrow_downward_rounded,
                  color: const Color(0xFF69F0AE),
                  currencySymbol: currencySymbol,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatChip(
                  label: l10n.expense,
                  amount: expense,
                  icon: Icons.arrow_upward_rounded,
                  color: const Color(0xFFFF8A80),
                  currencySymbol: currencySymbol,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    final prefix = amount < 0 ? '-$currencySymbol' : currencySymbol;
    return '$prefix${amount.abs().toStringAsFixed(2)}';
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color color;
  final String currencySymbol;

  const _StatChip({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
    required this.currencySymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                
                fontSize: 11,
                color: Colors.white60,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '$currencySymbol${amount.toStringAsFixed(0)}',
              style: TextStyle(
                
                fontSize: 15,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
