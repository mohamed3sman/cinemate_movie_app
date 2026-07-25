import 'package:movie_app/core/config/flavor.dart';

class AppConfig {
  final Flavor flavor;
  final String appName;
  final String baseUrl;

  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  static late AppConfig instance;
}
