import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';

class MovieSectionTitle extends StatelessWidget {
  final String title;

  const MovieSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Text(title, style: AppTextStyles.font18WhiteSemiBold),
    );
  }
}
