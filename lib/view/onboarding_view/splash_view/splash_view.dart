import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice_project/view/onboarding_view/splash_view/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: Center(
        child: SvgPicture.asset(AppAssets.splashLogo),
      ),
    );
  }
}
