import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'movie_section_title.dart';

class MovieProductionSection extends StatelessWidget {
  final List<String> companies;

  const MovieProductionSection({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    if (companies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MovieSectionTitle(title: 'Production'),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    companies[index],
                    style: AppTextStyles.font12GreyRegular.copyWith(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
