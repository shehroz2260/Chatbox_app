import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/view/main_view/contacts_tab/contact_tab_view.dart';
import 'package:practice_project/view/main_view/contacts_tab/contacts_tab_controller.dart';
import 'package:practice_project/view/main_view/message_tab/message_tab_controller.dart';
import 'package:practice_project/view/main_view/message_tab/message_tab_view.dart';
import 'package:practice_project/view/main_view/setting_tab/profile_view/profile_view.dart';
import 'package:practice_project/view/main_view/setting_tab/setting_tab_view.dart';
import 'package:practice_project/view/search_view/search_view.dart';
import 'call_tab/call_tab_view.dart';
import 'contacts_tab/group_chat/create_group_chat.dart';

class MainController extends GetxController {
  Widget _currentTab = _mainTab[0];
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  Widget get currentTab => _currentTab;
  void indexUpdate(int index) {
    _currentIndex = index;
    _currentTab = _mainTab[index];
    update();
  }

  void onSearchTap() {
    currentIndex == 0
        ? {
            Get.to(() => SearchView(
                  threads: Get.find<MessageTabController>().messagesList,
                  users: const [],
                ))
          }
        : currentIndex == 1
            ? {}
            : currentIndex == 2
                ? {
                    Get.to(() => SearchView(
                          threads: const [],
                          users: Get.find<ContactTabController>().contactList,
                        ))
                  }
                : {};
  }

  void onActioButtonTap() {
    currentIndex == 0
        ? {Get.to(() => const ProfileView())}
        : currentIndex == 1
            ? {}
            : currentIndex == 2
                ? {
                    Get.to(() => CreateGroupChat(
                          contactList:
                              Get.find<ContactTabController>().contactList,
                        ))
                  }
                : {};
  }
}

const List<Widget> _mainTab = <Widget>[
  MessageTabView(),
  CallTabView(),
  ContactTabView(),
  SettingTabView(),
];
const List<String> labelText = <String>[
  "Message",
  "Calls",
  "Contacts",
  "Settings"
];
