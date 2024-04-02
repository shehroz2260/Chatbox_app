import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:resize/resize.dart';
import '../utils/app_text_style.dart';

class SettingTabWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  final bool isLogout;
  final void Function()? onTap;
  const SettingTabWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: subTitle.isEmpty ? 0 : 25.h, top: subTitle.isEmpty ? 5.h : 0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 44.h,
              width: 44.w,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xffF2F8F7), shape: BoxShape.circle),
              child: SvgPicture.asset(
                icon,
                colorFilter: isLogout
                    ? const ColorFilter.mode(
                        AppColors.redColor, BlendMode.srcIn)
                    : null,
              ),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyle.carosFont16.copyWith(
                        color: isLogout
                            ? AppColors.redColor
                            : AppColors.blackColor)),
                if (subTitle.isNotEmpty)
                  Text(
                    subTitle,
                    style: AppTextStyle.circularFont12,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
