import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_gap.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'main_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.appBgColor,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: BottomNavBAr(
                currentIndex: controller.currentIndex,
                onTap: controller.indexUpdate,
              ),
            ),
            body: Container(
              width: Get.width,
              color: AppColors.blackColor,
              child: Column(
                children: [
                  AppGap.height60,
                  CustomAppBar(
                    onActionButtonTap: controller.onActioButtonTap,
                    currentIndex: controller.currentIndex,
                    onTap: controller.onSearchTap,
                  ),
                  AppGap.height30,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.appBgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: controller.currentTab,
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
