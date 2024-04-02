import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/utils/app_text_style.dart';
import 'package:practice_project/view/onboarding_view/welcome_view/welcome_controller.dart';
import 'package:resize/resize.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/welcome_widget.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.onboardingBack), fit: BoxFit.fill)),
        child: Column(
          children: [
            AppGap.height60,
            SvgPicture.asset(AppAssets.welcomLogo),
            AppGap.height44,
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: AppStrings.connectFriend,
                  style: AppTextStyle.carosFont68),
              TextSpan(
                  text: AppStrings.easily,
                  style: AppTextStyle.carosFont68
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(
                  text: AppStrings.and,
                  style: AppTextStyle.carosFont68
                      .copyWith(fontFamily: "")
                      .copyWith(fontWeight: FontWeight.w600)),
              TextSpan(
                  text: AppStrings.quickly,
                  style: AppTextStyle.carosFont68
                      .copyWith(fontWeight: FontWeight.w600))
            ])),
            AppGap.height16,
            Text(
              AppStrings.ourChatAppisThePerfect,
              style: AppTextStyle.circularFont16,
            ),
            AppGap.height40,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WelcomeWidget(
                  icon: AppAssets.facebookIcon,
                ),
                SizedBox(width: 15.w),
                const WelcomeWidget(
                  icon: AppAssets.googleIcon,
                ),
                SizedBox(width: 15.w),
                const WelcomeWidget(
                  icon: AppAssets.appleIcon,
                ),
              ],
            ),
            AppGap.height30,
            Row(
              children: [
                Expanded(
                  child: Divider(
                    endIndent: 15.w,
                    color: AppColors.borderColor,
                  ),
                ),
                Text(
                  AppStrings.or,
                  style: AppTextStyle.circularFont14,
                ),
                Expanded(
                  child: Divider(
                    indent: 15.w,
                    color: AppColors.borderColor,
                  ),
                ),
              ],
            ),
            AppGap.height30,
            CustomButton(
              onTap: controller.onSignUp,
              name: AppStrings.signUpWithMail,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.existingAccount,
                  style: AppTextStyle.circularFont14,
                ),
                GestureDetector(
                  onTap: controller.onLogin,
                  child: Text(AppStrings.logIn,
                      style: AppTextStyle.circularFont14.copyWith(
                          color: AppColors.appBgColor,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            AppGap.height40,
          ],
        ),
      ),
    );
  }
}
