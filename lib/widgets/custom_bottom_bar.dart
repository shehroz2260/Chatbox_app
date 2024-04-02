import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice_project/view/main_view/main_controller.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';

class BottomNavBAr extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const BottomNavBAr({
    super.key,
    this.onTap,
    required this.currentIndex,
  });
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.appBgColor,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const SizedBox(height: 7),
              SvgPicture.asset(
                AppAssets.messageIcon,
                height: 20,
                colorFilter: ColorFilter.mode(
                    currentIndex == 0
                        ? AppColors.greenColor
                        : AppColors.greyTextColor,
                    BlendMode.srcIn),
              ),
              const SizedBox(height: 7),
              Text(
                labelText[0],
                style: AppTextStyle.carosFont16.copyWith(
                  color: currentIndex == 0
                      ? AppColors.greenColor
                      : AppColors.greyTextColor,
                  height: 0,
                ),
              )
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const SizedBox(height: 7),
              SvgPicture.asset(
                AppAssets.callLogo,
                height: 20,
                colorFilter: ColorFilter.mode(
                    currentIndex == 1
                        ? AppColors.greenColor
                        : AppColors.greyTextColor,
                    BlendMode.srcIn),
              ),
              const SizedBox(height: 7),
              Text(
                labelText[1],
                style: AppTextStyle.carosFont16.copyWith(
                  color: currentIndex == 1
                      ? AppColors.greenColor
                      : AppColors.greyTextColor,
                  height: 0,
                ),
              )
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const SizedBox(height: 7),
              SvgPicture.asset(
                AppAssets.userIcon,
                height: 20,
                colorFilter: ColorFilter.mode(
                    currentIndex == 2
                        ? AppColors.greenColor
                        : AppColors.greyTextColor,
                    BlendMode.srcIn),
              ),
              const SizedBox(height: 7),
              Text(
                labelText[2],
                style: AppTextStyle.carosFont16.copyWith(
                  color: currentIndex == 2
                      ? AppColors.greenColor
                      : AppColors.greyTextColor,
                  height: 0,
                ),
              )
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const SizedBox(height: 7),
              SvgPicture.asset(
                AppAssets.settingIcon,
                height: 20,
                colorFilter: ColorFilter.mode(
                    currentIndex == 3
                        ? AppColors.greenColor
                        : AppColors.greyTextColor,
                    BlendMode.srcIn),
              ),
              const SizedBox(height: 7),
              Text(
                labelText[3],
                style: AppTextStyle.carosFont16.copyWith(
                  height: 0,
                  color: currentIndex == 3
                      ? AppColors.greenColor
                      : AppColors.greyTextColor,
                ),
              )
            ],
          ),
          label: "",
        ),
      ],
    );
  }
}
