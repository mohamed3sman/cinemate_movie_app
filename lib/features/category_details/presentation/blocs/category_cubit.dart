import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movies_by_category.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetMoviesByCategoryUseCase getMoviesByCategoryUseCase;

  CategoryCubit({required this.getMoviesByCategoryUseCase})
      : super(CategoryInitial());

  Future<void> loadCategoryMovies(int? genreId) async {
    try {
      emit(CategoryLoading());
      final movies = await getMoviesByCategoryUseCase.call(genreId);
      emit(CategoryLoaded(movies));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
