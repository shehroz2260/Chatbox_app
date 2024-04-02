import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:resize/resize.dart';

class BackButtonWidget extends StatelessWidget {
  final bool isBackWhite;
  const BackButtonWidget({super.key, this.isBackWhite = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: SvgPicture.asset(
        AppAssets.arrowBackIcon,
        colorFilter: ColorFilter.mode(
            isBackWhite ? AppColors.blackColor : AppColors.appBgColor,
            BlendMode.srcIn),
        height: 12.h,
        width: 8.w,
      ),
    );
  }
}
