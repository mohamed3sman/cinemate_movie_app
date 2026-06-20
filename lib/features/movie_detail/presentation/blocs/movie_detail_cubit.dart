import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie_detail/domain/usecases/get_movie_detail.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetailUseCase getMovieDetailUseCase;

  MovieDetailCubit({required this.getMovieDetailUseCase})
    : super(MovieDetailInitial());

  Future<void> loadMovieDetail(int id) async {
    try {
      emit(MovieDetailLoading());
      final movieDetail = await getMovieDetailUseCase(id);
      emit(MovieDetailLoaded(movieDetail));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
