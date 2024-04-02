import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import '../utils/app_colors.dart';
import '../utils/app_gap.dart';
import '../utils/app_text_style.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  const ProfileInfoWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.circularFont14
              .copyWith(color: AppColors.greyTextColor),
        ),
        SizedBox(height: 5.h),
        Text(value, style: AppTextStyle.carosFont18),
        AppGap.height16
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String icon;
  const ProfileWidget({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 44.w,
      decoration:
          const BoxDecoration(color: Color(0xff051D13), shape: BoxShape.circle),
      padding: const EdgeInsets.all(10),
      child: SvgPicture.asset(
        icon,
        colorFilter:
            const ColorFilter.mode(AppColors.appBgColor, BlendMode.srcIn),
      ),
    );
  }
}
