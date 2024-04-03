import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/view/onboarding_view/auth_view/signup_view/create_profile/create_profile_controller.dart';
import 'package:practice_project/widgets/custom_button.dart';
import 'package:practice_project/widgets/custom_textfield.dart';
import 'package:resize/resize.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_gap.dart';
import '../../../../../utils/app_text_style.dart';

class CreateProfileView extends StatelessWidget {
  const CreateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProfileControllere());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.blackColor,
        child: Column(
          children: [
            AppGap.height60,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Profile",
                    style: AppTextStyle.carosFont20,
                  ),
                ],
              ),
            ),
            AppGap.height30,
            Expanded(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    color: AppColors.appBgColor),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GetBuilder<CreateProfileControllere>(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGap.height40,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => controller.imagePicker(true),
                            child: Container(
                              height: 100.h,
                              width: 100.h,
                              padding: EdgeInsets.all(
                                  controller.pickedFile != null ? 0 : 30),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.borderColor, width: 1)),
                              child: controller.pickedFile == null
                                  ? SvgPicture.asset(AppAssets.camera)
                                  : Image.file(
                                      controller.pickedFile!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () => controller.imagePicker(false),
                            child: Container(
                              padding: EdgeInsets.all(
                                  controller.pickedFile != null ? 0 : 30),
                              height: 100.h,
                              width: 100.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.borderColor, width: 1)),
                              child: controller.pickedFile == null
                                  ? const Icon(
                                      Icons.photo,
                                      size: 30,
                                    )
                                  : Image.file(
                                      controller.pickedFile!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )
                        ],
                      ),
                      AppGap.height30,
                      CustomTextField(
                        titleText: AppStrings.address,
                        controller: controller.addressController,
                      ),
                      AppGap.height16,
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        titleText: AppStrings.phoneNumber,
                        controller: controller.phoneController,
                      ),
                      AppGap.height16,
                      CustomTextField(
                        titleText: AppStrings.status,
                        controller: controller.statusController,
                      ),
                      AppGap.height16,
                      CustomButton(
                        name: AppStrings.save,
                        buttonColor: AppColors.greenColor,
                        textColor: AppColors.appBgColor,
                        onTap: controller.saveData,
                      )
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
