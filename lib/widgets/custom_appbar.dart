import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/controllers/admin_base_controller.dart';
import 'package:resize/resize.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../view/main_view/main_controller.dart';
import 'app_cached_image.dart';

class CustomAppBar extends StatelessWidget {
  final void Function() onTap, onActionButtonTap;
  final int currentIndex;
  const CustomAppBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
    required this.onActionButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentIndex == 3
                ? SizedBox(
                    width: 44.w,
                    height: 44.h,
                  )
                : GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 44.h,
                      width: 44.w,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greyColor)),
                      child: SvgPicture.asset(AppAssets.searchIcon),
                    ),
                  ),
            Text(
              labelText[currentIndex],
              style: AppTextStyle.carosFont20,
            ),
            currentIndex == 3
                ? SizedBox(
                    width: 44.w,
                    height: 44.h,
                  )
                : GestureDetector(
                    onTap: onActionButtonTap,
                    child: Container(
                      height: 44.h,
                      width: 44.w,
                      padding: EdgeInsets.all(currentIndex == 0 ? 0 : 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greyColor)),
                      child: currentIndex == 0
                          ? GetBuilder<AdminBaseController>(builder: (context) {
                              return AppCacheImage(
                                round: 44,
                                imageUrl: AdminBaseController.userData.profile,
                                boxFit: BoxFit.cover,
                              );
                            })
                          : SvgPicture.asset(currentIndex == 1
                              ? AppAssets.addCallUser
                              : AppAssets.addUser),
                    ),
                  ),
          ],
        ));
  }
}
