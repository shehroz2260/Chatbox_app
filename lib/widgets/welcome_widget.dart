import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import '../utils/app_colors.dart';

class WelcomeWidget extends StatelessWidget {
  final String icon;
  final void Function()? onTap;
  const WelcomeWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: 48.w,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderColor, width: 1)),
        child: SvgPicture.asset(
          icon,
        ),
      ),
    );
  }
}
