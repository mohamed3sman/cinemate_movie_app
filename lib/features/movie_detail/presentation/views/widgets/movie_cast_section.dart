import 'package:flutter/material.dart';
import 'package:movie_app/core/animations/fade_in_slide.dart';
import 'package:movie_app/features/movie_detail/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movie_detail/presentation/views/widgets/cast_card.dart';
import 'package:movie_app/core/animations/fade_slide_page_route.dart';
import 'package:movie_app/features/person_detail/presentation/views/person_detail_view.dart';
import 'movie_section_title.dart';

class MovieCastSection extends StatelessWidget {
  final List<CastMember> cast;
  final int movieId;

  const MovieCastSection({super.key, required this.cast, required this.movieId});

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
              final heroTag = 'cast_${member.id}_movie_$movieId';
              return FadeInSlide(
                delay: Duration(milliseconds: 80 * index),
                duration: const Duration(milliseconds: 450),
                beginOffset: const Offset(0.2, 0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    width: 200,
                    child: CastCard(
                      name: member.name,
                      role: member.role,
                      imageUrl: member.imageUrl,
                      heroTag: heroTag,
                      onTap: () {
                        if (member.id > 0) {
                          Navigator.push(
                            context,
                            FadeSlidePageRoute(
                              page: PersonDetailView(
                                personId: member.id,
                                imageUrl: member.imageUrl,
                                heroTag: heroTag,
                                name: member.name,
                              ),
                            ),
                          );
                        }
                      },
                    ),
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
              final heroTag = 'cast_${member.id}_movie_$movieId';
              return FadeInSlide(
                delay: Duration(milliseconds: 80 * index + 150),
                duration: const Duration(milliseconds: 450),
                beginOffset: const Offset(0.2, 0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    width: 200,
                    child: CastCard(
                      name: member.name,
                      role: member.role,
                      imageUrl: member.imageUrl,
                      heroTag: heroTag,
                      onTap: () {
                        if (member.id > 0) {
                          Navigator.push(
                            context,
                            FadeSlidePageRoute(
                              page: PersonDetailView(
                                personId: member.id,
                                imageUrl: member.imageUrl,
                                heroTag: heroTag,
                                name: member.name,
                              ),
                            ),
                          );
                        }
                      },
                    ),
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
