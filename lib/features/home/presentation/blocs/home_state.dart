import 'package:movie_app/features/home/domain/entities/movie.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> trendingMovies;
  final List<Movie> searchResults;
  final bool isSearching;
  final String searchQuery;

  HomeLoaded({
    required this.popularMovies,
    required this.topRatedMovies,
    required this.trendingMovies,
    this.searchResults = const [],
    this.isSearching = false,
    this.searchQuery = '',
  });

  HomeLoaded copyWith({
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? trendingMovies,
    List<Movie>? searchResults,
    bool? isSearching,
    String? searchQuery,
  }) {
    return HomeLoaded(
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
