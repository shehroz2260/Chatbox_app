import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/controllers/admin_base_controller.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:resize/resize.dart';
import '../../../utils/app_text_style.dart';
import '../../../widgets/setting_widget.dart';
import 'setting_tab_controller.dart';

class SettingTabView extends StatelessWidget {
  const SettingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingTabController());
    return Column(
      children: [
        AppGap.height40,
        GetBuilder<AdminBaseController>(builder: (context) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: controller.profileView,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 52.h,
                        width: 52.w,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: AppCacheImage(
                          imageUrl: AdminBaseController.userData.profile,
                          boxFit: BoxFit.cover,
                          round: 52,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AdminBaseController.userData.name,
                              style: AppTextStyle.carosFont18),
                          Text(
                            AdminBaseController.userData.status,
                            style: AppTextStyle.circularFont12,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              SvgPicture.asset(AppAssets.qrCode)
            ],
          );
        }),
        AppGap.height44,
        ...List.generate(settingTabWidgetList.length, (i) {
          return SettingTabWidget(
              title: settingTabWidgetList[i]["title"],
              subTitle: settingTabWidgetList[i]["subtitle"],
              icon: settingTabWidgetList[i]["icon"]);
        }),
        SettingTabWidget(
          isLogout: true,
          onTap: () {
            AppDialog.customOpenSetttingDialog(
                cancel: "No",
                message: "Do you really want to logout",
                onOk: "Ok",
                openSetting: () {
                  AuthServives().signout();
                },
                title: "Are you sure!");
          },
          title: "Logout",
          subTitle: "",
          icon: AppAssets.logout,
        )
      ],
    );
  }
}
