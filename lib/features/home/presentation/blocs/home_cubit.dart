import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:movie_app/features/home/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app/features/home/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/features/home/domain/usecases/search_movies.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetTrendingMoviesUseCase getTrendingMoviesUseCase;
  final SearchMoviesUseCase searchMoviesUseCase;

  Timer? _debounceTimer;

  HomeCubit({
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
    required this.getTrendingMoviesUseCase,
    required this.searchMoviesUseCase,
  }) : super(HomeInitial());

  Future<void> loadMovies() async {
    try {
      emit(HomeLoading());
      final results = await Future.wait([
        getPopularMoviesUseCase.call(),
        getTopRatedMoviesUseCase.call(),
        getTrendingMoviesUseCase.call(),
      ]);

      emit(
        HomeLoaded(
          popularMovies: results[0],
          topRatedMovies: results[1],
          trendingMovies: results[2],
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void searchMovies(String query) {
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      clearSearch();
      return;
    }

    // Show searching state immediately
    if (state is HomeLoaded) {
      emit((state as HomeLoaded).copyWith(
        isSearching: true,
        searchQuery: query,
      ));
    }

    // Debounce the actual API call by 500ms
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final searchResults = await searchMoviesUseCase.call(query);
        if (state is HomeLoaded) {
          emit((state as HomeLoaded).copyWith(
            searchResults: searchResults,
            isSearching: false,
            searchQuery: query,
          ));
        }
      } catch (e) {
        if (state is HomeLoaded) {
          emit((state as HomeLoaded).copyWith(
            searchResults: [],
            isSearching: false,
            searchQuery: query,
          ));
        }
      }
    });
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    if (state is HomeLoaded) {
      emit((state as HomeLoaded).copyWith(
        searchResults: [],
        isSearching: false,
        searchQuery: '',
      ));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
