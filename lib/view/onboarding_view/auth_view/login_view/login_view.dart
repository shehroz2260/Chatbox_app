import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/google_login_service.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/utils/app_text_style.dart';
import 'package:practice_project/widgets/back_button.dart';
import 'package:practice_project/widgets/custom_button.dart';
import 'package:resize/resize.dart';
import '../../../../utils/app_assets.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/welcome_widget.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGap.height60,
            const BackButtonWidget(),
            AppGap.height70,
            Align(
              alignment: Alignment.center,
              child: Text(
                AppStrings.logInToChatbox,
                style: AppTextStyle.carosFont18,
              ),
            ),
            AppGap.height16,
            Text(
              AppStrings.welcomeBAckSigninUsingYourSocial,
              style: AppTextStyle.circularFont14
                  .copyWith(color: AppColors.greyTextColor),
              textAlign: TextAlign.center,
            ),
            AppGap.height30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WelcomeWidget(
                  icon: AppAssets.facebookIcon,
                ),
                SizedBox(width: 15.w),
                const WelcomeWidget(
                  onTap: GoogleLoginService.signInWithGoogle,
                  icon: AppAssets.googleIcon,
                ),
                if (Platform.isIOS) SizedBox(width: 15.w),
                if (Platform.isIOS)
                  const WelcomeWidget(
                    icon: AppAssets.blackAppleIcon,
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
            Expanded(
              child: GetBuilder<LoginController>(builder: (context) {
                return Column(
                  children: [
                    CustomTextField(
                      controller: controller.emailController,
                      onChanged: controller.onEmailChnaged,
                      hintText: AppStrings.yourEmail,
                    ),
                    AppGap.height30,
                    CustomTextField(
                      controller: controller.passwordController,
                      onChanged: controller.onPasswordChnaged,
                      hintText: AppStrings.password,
                    ),
                    const Spacer(),
                    CustomButton(
                        onTap: controller.login,
                        buttonColor: controller.buttonDisable()
                            ? AppColors.lightGreyColor
                            : AppColors.greenColor,
                        textColor: controller.buttonDisable()
                            ? AppColors.greyTextColor
                            : AppColors.appBgColor,
                        name: AppStrings.logIn),
                  ],
                );
              }),
            ),
            AppGap.height16,
            Align(
              alignment: Alignment.center,
              child: Text(
                AppStrings.forgotpassword,
                style: AppTextStyle.circularFont14.copyWith(
                    color: AppColors.greenColor, fontWeight: FontWeight.w500),
              ),
            ),
            AppGap.height40
          ],
        ),
      ),
    );
  }
}
