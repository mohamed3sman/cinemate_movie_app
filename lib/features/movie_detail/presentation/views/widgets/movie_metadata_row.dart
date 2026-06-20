import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';

class MovieMetadataRow extends StatelessWidget {
  final String releaseDate;
  final int runtime;

  const MovieMetadataRow({
    super.key,
    required this.releaseDate,
    required this.runtime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          _buildMetadataItem(
            Icons.calendar_today_outlined,
            releaseDate.split('-')[0],
          ),
          const SizedBox(width: 16),
          _buildMetadataItem(
            Icons.access_time_outlined,
            '$runtime min',
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.font12GreyRegular.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
