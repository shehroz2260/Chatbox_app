import 'package:get/get.dart';
import 'package:practice_project/view/main_view/setting_tab/profile_view/profile_view.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_strings.dart';

class SettingTabController extends GetxController {
  void profileView() {
    Get.to(() => const ProfileView());
  }
}

List<Map<String, dynamic>> settingTabWidgetList = [
  {
    "icon": AppAssets.account,
    "title": AppStrings.account,
    "subtitle": AppStrings.privacySecurityChangeNumber
  },
  {
    "icon": AppAssets.messageIcon,
    "title": AppStrings.chat,
    "subtitle": AppStrings.chatHistoryThemeWallpapers
  },
  {
    "icon": AppAssets.notification,
    "title": AppStrings.notifications,
    "subtitle": AppStrings.messagesGroupAndOthers
  },
  {
    "icon": AppAssets.helps,
    "title": AppStrings.help,
    "subtitle": AppStrings.helpCenterContactUsPrivacyPolicy
  },
  {
    "icon": AppAssets.data,
    "title": AppStrings.storageAndData,
    "subtitle": AppStrings.networkUsageStogareUsage
  },
  // {
  //   "icon": AppAssets.inviteFriend,
  //   "title": AppStrings.inviteAFriend,
  //   "subtitle": ""
  // },
];
