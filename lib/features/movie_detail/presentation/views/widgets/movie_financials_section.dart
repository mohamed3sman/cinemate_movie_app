import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'movie_section_title.dart';

class MovieFinancialsSection extends StatelessWidget {
  final int budget;
  final int revenue;

  const MovieFinancialsSection({
    super.key,
    required this.budget,
    required this.revenue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MovieSectionTitle(title: 'Financials'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              _AnimatedFinancialItem(
                label: 'Budget',
                amount: budget,
                delay: const Duration(milliseconds: 0),
              ),
              const SizedBox(width: 32),
              _AnimatedFinancialItem(
                label: 'Revenue',
                amount: revenue,
                delay: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnimatedFinancialItem extends StatelessWidget {
  final String label;
  final int amount;
  final Duration delay;

  const _AnimatedFinancialItem({
    required this.label,
    required this.amount,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.font12GreyRegular),
                const SizedBox(height: 4),
                // Animate the counter value
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: amount.toDouble()),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutCubic,
                  builder: (context, countValue, child) {
                    return Text(
                      _formatCurrency(countValue.toInt()),
                      style: AppTextStyles.font15WhiteBold,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatCurrency(int amount) {
    if (amount == 0) return 'Unknown';
    if (amount >= 1000000000) {
      return '\$${(amount / 1000000000).toStringAsFixed(1)}B';
    }
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    }
    return '\$$amount';
  }
}
