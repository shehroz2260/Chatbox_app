import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/view/controllers/admin_base_controller.dart';
import 'package:practice_project/view/main_view/setting_tab/profile_view/edit_profile_view/edit_profile_view.dart';
import 'package:practice_project/view/main_view/setting_tab/profile_view/profile_controller.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:practice_project/widgets/back_button.dart';
import 'package:resize/resize.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../widgets/profile_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.blackColor,
        child: GetBuilder<AdminBaseController>(builder: (context) {
          return Column(
            children: [
              AppGap.height60,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButtonWidget(isBackWhite: false),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 82.h,
                          width: 82.w,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: AppCacheImage(
                            imageUrl: AdminBaseController.userData.profile,
                            round: 82,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.changeProfileImage,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appBgColor),
                            child: const Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 8)
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AdminBaseController.userData.name,
                      style: AppTextStyle.carosFont20
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    AdminBaseController.userData.email,
                    style: AppTextStyle.circularFont12,
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ProfileWidget(icon: AppAssets.messageIcon),
                  SizedBox(width: 10.w),
                  const ProfileWidget(icon: AppAssets.videoCall),
                  SizedBox(width: 10.w),
                  const ProfileWidget(icon: AppAssets.audioCall),
                  SizedBox(width: 10.w),
                  const ProfileWidget(icon: AppAssets.moreIcon),
                ],
              ),
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
                      ProfileInfoWidget(
                        ontap: () {
                          Get.to(() => EditProfileView(
                                value: AdminBaseController.userData.name,
                                title: AppStrings.displayName,
                              ));
                        },
                        title: AppStrings.displayName,
                        value: AdminBaseController.userData.name,
                      ),
                      ProfileInfoWidget(
                        isEmailField: true,
                        ontap: () {
                          Get.to(() => EditProfileView(
                                value: AdminBaseController.userData.email,
                                title: AppStrings.emailAddress,
                              ));
                        },
                        title: AppStrings.emailAddress,
                        value: AdminBaseController.userData.email,
                      ),
                      ProfileInfoWidget(
                        ontap: () {
                          Get.to(() => EditProfileView(
                                value: AdminBaseController.userData.address,
                                title: AppStrings.address,
                              ));
                        },
                        title: AppStrings.address,
                        value: AdminBaseController.userData.address,
                      ),
                      ProfileInfoWidget(
                        ontap: () {
                          Get.to(() => EditProfileView(
                                value: AdminBaseController.userData.phoneNumber,
                                title: AppStrings.phoneNumber,
                              ));
                        },
                        title: AppStrings.phoneNumber,
                        value: AdminBaseController.userData.phoneNumber,
                      ),
                      ProfileInfoWidget(
                        ontap: () {
                          Get.to(() => EditProfileView(
                                value: AdminBaseController.userData.status,
                                title: AppStrings.status,
                              ));
                        },
                        title: AppStrings.status,
                        value: AdminBaseController.userData.status,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
