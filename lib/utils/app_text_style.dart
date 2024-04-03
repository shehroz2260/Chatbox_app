import 'package:flutter/material.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:resize/resize.dart';

class AppTextStyle {
  static const String carosFont = "Caros";
  static const String circularStudFont = "Circular Stud";
  static const TextStyle carosStyle = TextStyle(fontFamily: carosFont);
  static const TextStyle circularStyle =
      TextStyle(fontFamily: circularStudFont);
  static TextStyle carosFont68 = carosStyle.copyWith(
      color: AppColors.appBgColor, fontSize: 68.sp, height: 1);
  static TextStyle circularFont16 = circularStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColors.greyColor,
      fontSize: 16.sp,
      height: 1);
  static TextStyle carosFont16 = circularStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColors.blackColor,
      fontSize: 16.sp,
      height: 1);
  static TextStyle carosFont18 = circularStyle.copyWith(
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
      fontSize: 18.sp,
      height: 1);
  static TextStyle carosFont20 = circularStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.appBgColor,
    fontSize: 20.sp,
  );
  static TextStyle carosFont40 = circularStyle.copyWith(
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
    fontSize: 40.sp,
  );
  static TextStyle circularFont14 = circularStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColors.greyColor,
      fontSize: 14.sp,
      height: 1);
  static TextStyle circularFont12 = circularStyle.copyWith(
    fontWeight: FontWeight.w400,
    color: AppColors.greyTextColor,
    fontSize: 12.sp,
  );
}
