import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color? buttonColor;
  final Color? textColor;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.name,
    this.onTap,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: buttonColor ?? AppColors.appBgColor),
        alignment: Alignment.center,
        child: Text(
          name,
          style: AppTextStyle.carosFont16.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.blackColor),
        ),
      ),
    );
  }
}
