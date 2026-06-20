import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_colors.dart';
import 'core/utils/size_config.dart';
import 'core/widgets/global_mini_player.dart';
import 'features/movie_detail/presentation/blocs/trailer_cubit.dart';
import 'features/onboarding/presentation/views/onboarding_view.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await di.init();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<TrailerCubit>(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF00E5FF),
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Roboto',
        ),
        builder: (context, child) {
          SizeConfig().init(context);
          return GlobalMiniPlayer(child: child!);
        },
        home: const OnboardingView(),
      ),
    );
  }
}
