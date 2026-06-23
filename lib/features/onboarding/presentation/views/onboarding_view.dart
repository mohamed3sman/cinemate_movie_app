import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/utils/app_images.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/core/widgets/gradient_border_container.dart';
import 'package:movie_app/features/home/presentation/views/home_view.dart';
import 'package:movie_app/core/utils/size_config.dart';
import 'package:movie_app/core/animations/fade_in_slide.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Poster image fades in from top
            FadeInSlide(
              duration: const Duration(milliseconds: 800),
              beginOffset: const Offset(0, -0.1),
              child: Image.asset(AppImages.onboardingImage, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Title fades in after image
                  FadeInSlide(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'Cinemate',
                      style: AppTextStyles.font24WhiteBold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Subtitle fades in staggered
                  FadeInSlide(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'Watch everything you want\nfor free!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14GreyRegular,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Button fades in last with a slight upward push
                  FadeInSlide(
                    delay: const Duration(milliseconds: 900),
                    duration: const Duration(milliseconds: 700),
                    beginOffset: const Offset(0, 0.3),
                    child: GradientBorderContainer(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HomeView(),
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOut,
                                ),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Text(
                          'Enter now',
                          style: AppTextStyles.font16WhiteRegular.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
