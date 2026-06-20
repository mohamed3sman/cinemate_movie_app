import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/core/utils/app_images.dart';
import 'package:movie_app/core/theme/app_text_styles.dart';
import 'package:movie_app/core/widgets/gradient_border_container.dart';
import 'package:movie_app/features/home/presentation/views/home_view.dart';
import 'package:movie_app/core/utils/size_config.dart';

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
            Image.asset(AppImages.onboardingImage, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text('Cinemate', style: AppTextStyles.font24WhiteBold),
                  const SizedBox(height: 16),
                  Text(
                    'Watch everything you want\nfor free!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font14GreyRegular,
                  ),
                  const SizedBox(height: 48),
                  GradientBorderContainer(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
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
