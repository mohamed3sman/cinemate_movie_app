import '../../../home/domain/entities/movie.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Movie> movies;
  CategoryLoaded(this.movies);
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
