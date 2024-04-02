import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/utils/app_text_style.dart';
import 'package:practice_project/widgets/back_button.dart';
import 'package:practice_project/widgets/custom_button.dart';
import 'package:resize/resize.dart';
import '../../../../widgets/custom_textfield.dart';
import 'signup_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
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
                AppStrings.signUpWithMail,
                style: AppTextStyle.carosFont18,
              ),
            ),
            AppGap.height16,
            Text(
              AppStrings.getChattingwithFriendAndFamily,
              style: AppTextStyle.circularFont14
                  .copyWith(color: AppColors.greyTextColor),
              textAlign: TextAlign.center,
            ),
            AppGap.height30,
            Expanded(
              child: GetBuilder<SignUpController>(builder: (context) {
                return Column(
                  children: [
                    CustomTextField(
                      controller: controller.nameController,
                      onChanged: controller.onNameChnaged,
                      hintText: AppStrings.yourName,
                    ),
                    AppGap.height30,
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
                    AppGap.height30,
                    CustomTextField(
                      controller: controller.cPasswordController,
                      onChanged: controller.onCPasswordChnaged,
                      hintText: AppStrings.confirmPassword,
                    ),
                    const Spacer(),
                    CustomButton(
                        onTap: controller.signup,
                        buttonColor: controller.buttonDisable()
                            ? AppColors.lightGreyColor
                            : AppColors.greenColor,
                        textColor: controller.buttonDisable()
                            ? AppColors.greyTextColor
                            : AppColors.appBgColor,
                        name: AppStrings.signUpWithMail),
                  ],
                );
              }),
            ),
            AppGap.height40
          ],
        ),
      ),
    );
  }
}
