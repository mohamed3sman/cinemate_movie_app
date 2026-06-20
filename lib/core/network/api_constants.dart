class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '5f89d0402ba31e6c326c7a7e81f6b164';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Movie Routes
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String trendingMovies = '/trending/movie/week';
  static const String discoverMovies = '/discover/movie';
  static const int animationGenreId = 16;
  static String movieDetail(int id) => '/movie/$id';
  static const String searchMovies = '/search/movie';
}
