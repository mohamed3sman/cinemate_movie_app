class BaseResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  BaseResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return BaseResponse<T>(
      page: json['page'] as int,
      results: (json['results'] as List).map((e) => fromJsonT(e)).toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
