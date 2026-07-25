import 'core/config/app_config.dart';
import 'core/config/flavor.dart';
import 'main.dart';

void main() {
  bootstrap(
    const AppConfig(
      flavor: Flavor.development,
      appName: 'Cinemate Dev',
      baseUrl: 'https://dev-api.themoviedb.org/3',
    ),
  );
}
