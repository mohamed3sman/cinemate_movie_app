import 'package:flutter/material.dart';
import 'package:movie_app/features/home/domain/entities/movie.dart';
import 'package:movie_app/features/home/presentation/views/widgets/movie_horizontal_section.dart';

class PersonDetailSkeleton extends StatelessWidget {
  const PersonDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              _buildSkeletonText(100),
              const SizedBox(width: 24),
              _buildSkeletonText(100),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _buildSkeletonText(150),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _buildSkeletonText(120, height: 20),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildSkeletonText(double.infinity),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        MovieHorizontalSection(
          title: 'Known For',
          isLoading: true,
          movies: List.generate(
            5,
            (index) => const Movie(
              id: 0,
              title: 'Loading',
              backdropPath: '',
              posterPath: '',
              releaseDate: '2024',
              overview: '',
              voteAverage: 0,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSkeletonText(double width, {double height = 14}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
