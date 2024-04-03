import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/view/main_view/setting_tab/profile_view/edit_profile_view/edit_profile_controller.dart';
import 'package:practice_project/widgets/custom_button.dart';
import 'package:practice_project/widgets/custom_textfield.dart';
import 'package:resize/resize.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_gap.dart';
import '../../../../../utils/app_text_style.dart';
import '../../../../../widgets/back_button.dart';

class EditProfileView extends StatelessWidget {
  final String title;
  final String value;
  const EditProfileView({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    controller.fieldController.text = value;
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.blackColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGap.height60,
            Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: const BackButtonWidget(isBackWhite: false)),
            Align(
              alignment: Alignment.center,
              child: Text("Edit $title",
                  style: AppTextStyle.carosFont20
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 10.h),
            Expanded(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    color: AppColors.appBgColor),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGap.height40,
                    CustomTextField(
                      hintText: title,
                      controller: controller.fieldController,
                    ),
                    AppGap.height30,
                    CustomButton(
                      onTap: title == AppStrings.displayName
                          ? controller.updateName
                          : title == AppStrings.address
                              ? controller.updateAddress
                              : title == AppStrings.phoneNumber
                                  ? controller.updatePhone
                                  : title == AppStrings.status
                                      ? controller.updateStatus
                                      : () {},
                      name: "Change",
                      textColor: AppColors.appBgColor,
                      buttonColor: AppColors.greenColor,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
