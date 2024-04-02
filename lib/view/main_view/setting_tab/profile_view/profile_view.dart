import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/utils/constants.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:practice_project/widgets/back_button.dart';
import 'package:resize/resize.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../widgets/profile_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButtonWidget(isBackWhite: false),
                  Container(
                    height: 82.h,
                    width: 82.w,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: AppCacheImage(
                      imageUrl: Constant.userModel.profile,
                      round: 82,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8)
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(Constant.userModel.name,
                    style: AppTextStyle.carosFont20
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(
                  Constant.userModel.email,
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
                      title: AppStrings.displayName,
                      value: Constant.userModel.name,
                    ),
                    ProfileInfoWidget(
                      title: AppStrings.emailAddress,
                      value: Constant.userModel.email,
                    ),
                    ProfileInfoWidget(
                      title: AppStrings.address,
                      value: Constant.userModel.address,
                    ),
                    ProfileInfoWidget(
                      title: AppStrings.phoneNumber,
                      value: Constant.userModel.phoneNumber,
                    ),
                    // SizedBox(height: 5.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       AppStrings.mediaShared,
                    //       style: AppTextStyle.circularFont14
                    //           .copyWith(color: AppColors.greyTextColor),
                    //     ),
                    //     Text(
                    //       "View All",
                    //       style: AppTextStyle.circularFont14.copyWith(
                    //           color: const Color(0xff20A090),
                    //           fontWeight: FontWeight.w500),
                    //     )
                    //   ],
                    // )
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
