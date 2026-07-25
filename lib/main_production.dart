import 'core/config/app_config.dart';
import 'core/config/flavor.dart';
import 'main.dart';

void main() {
  bootstrap(
    const AppConfig(
      flavor: Flavor.production,
      appName: 'Cinemate',
      baseUrl: 'https://api.themoviedb.org/3',
    ),
  );
}
