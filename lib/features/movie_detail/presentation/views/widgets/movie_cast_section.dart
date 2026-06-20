import 'package:flutter/material.dart';
import 'package:movie_app/features/movie_detail/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/cast_card.dart';
import 'movie_section_title.dart';

class MovieCastSection extends StatelessWidget {
  final List<CastMember> cast;

  const MovieCastSection({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MovieSectionTitle(title: 'Cast'),
        SizedBox(
          height: 75,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: (cast.length / 2).ceil(),
            itemBuilder: (context, index) {
              final member = cast[index * 2];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  width: 200,
                  child: CastCard(
                    name: member.name,
                    role: member.role,
                    imageUrl: member.imageUrl,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 75,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: cast.length ~/ 2,
            itemBuilder: (context, index) {
              final member = cast[index * 2 + 1];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  width: 200,
                  child: CastCard(
                    name: member.name,
                    role: member.role,
                    imageUrl: member.imageUrl,
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
