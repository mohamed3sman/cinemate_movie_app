import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Home
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_popular_movies.dart';
import 'features/home/domain/usecases/get_top_rated_movies.dart';
import 'features/home/domain/usecases/get_trending_movies.dart';
import 'features/home/domain/usecases/search_movies.dart';
import 'features/home/presentation/blocs/home_cubit.dart';

// Movie Detail
import 'features/movie_detail/data/datasources/movie_detail_remote_data_source.dart';
import 'features/movie_detail/data/repositories/movie_detail_repository_impl.dart';
import 'features/movie_detail/domain/repositories/movie_detail_repository.dart';
import 'features/movie_detail/domain/usecases/get_movie_detail.dart';
import 'features/movie_detail/presentation/blocs/movie_detail_cubit.dart';
import 'features/movie_detail/presentation/blocs/trailer_cubit.dart';

// Category Details
import 'features/category_details/data/datasources/category_remote_data_source.dart';
import 'features/category_details/data/repositories/category_repository_impl.dart';
import 'features/category_details/domain/repositories/category_repository.dart';
import 'features/category_details/domain/usecases/get_movies_by_category.dart';
import 'features/category_details/presentation/blocs/category_cubit.dart';



final sl = GetIt.instance;

Future<void> init() async {
  // --- CORE ---
  sl.registerLazySingleton(() => Dio());

  // --- CATEGORY DETAILS ---
  // Cubit
  sl.registerFactory(() => CategoryCubit(getMoviesByCategoryUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMoviesByCategoryUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(dio: sl()),
  );



  // --- HOME ---
  // Cubit
  sl.registerFactory(
    () => HomeCubit(
      getPopularMoviesUseCase: sl(),
      getTopRatedMoviesUseCase: sl(),
      getTrendingMoviesUseCase: sl(),
      searchMoviesUseCase: sl(),
    ),
  );
  
  // Use cases
  sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetTrendingMoviesUseCase(sl()));
  sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));
  
  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dio: sl()),
  );

  // --- MOVIE DETAIL ---
  // Cubit
  sl.registerFactory(() => MovieDetailCubit(getMovieDetailUseCase: sl()));
  sl.registerLazySingleton(() => TrailerCubit());
  
  // Use cases
  sl.registerLazySingleton(() => GetMovieDetailUseCase(sl()));
  
  // Repository
  sl.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Data sources
  sl.registerLazySingleton<MovieDetailRemoteDataSource>(
    () => MovieDetailRemoteDataSourceImpl(dio: sl()),
  );
}
