import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_colors.dart';
import 'core/utils/size_config.dart';
import 'core/widgets/global_mini_player.dart';
import 'features/movie_detail/presentation/blocs/trailer_cubit.dart';
import 'features/onboarding/presentation/views/onboarding_view.dart';
import 'injection_container.dart' as di;

class MovieApp extends StatelessWidget {
  final AppConfig config;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MovieApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<TrailerCubit>(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: config.appName,
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
