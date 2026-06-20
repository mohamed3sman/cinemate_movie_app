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
              _buildFinancialItem(
                'Budget',
                _formatCurrency(budget),
              ),
              const SizedBox(width: 32),
              _buildFinancialItem(
                'Revenue',
                _formatCurrency(revenue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font12GreyRegular),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.font15WhiteBold),
      ],
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
    return '\$${amount.toString()}';
  }
}
