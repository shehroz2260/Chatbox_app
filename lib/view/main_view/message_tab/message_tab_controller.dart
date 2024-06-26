import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:practice_project/models/chat_model.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/controllers/admin_base_controller.dart';
import 'package:practice_project/controllers/base_controller.dart';
import '../../../../models/thread_model.dart';
import '../../../../models/user_model.dart';

class MessageTabController extends GetxController {
  ThreadModel? threadModel;
  bool isLoading = false;
  List<ThreadModel> messagesList = [];
  int unreadCount = 0;
  bool isActive = false;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? loadThreadsSub;
  @override
  void onInit() {
    loadMessages();
    // loadGroups();
    super.onInit();
  }

  @override
  void dispose() {
    loadThreadsSub?.cancel();
    super.dispose();
  }

  void loadMessages() async {
    isLoading = true;
    loadThreadsSub = FirebaseFirestore.instance
        .collection(ThreadModel.tableName)
        .where("participantUserList",
            arrayContains: AdminBaseController.userData.uid)
        .snapshots()
        .listen((event) async {
      List<ThreadModel> threads = [];
      messagesList = [];
      update();
      if (event.docs.isNotEmpty) {
        unreadCount = 0;

        for (var snapShot in event.docs) {
          var threadModel = ThreadModel.fromMap(snapShot.data());
          final uid = threadModel.participantUserList[0] ==
                  AdminBaseController.userData.uid
              ? threadModel.participantUserList[1]
              : threadModel.participantUserList[0];
          UserModel? userModel = await AuthServives().getUserById(uid: uid);
          threadModel.userDetail = userModel;

          FirebaseFirestore.instance
              .collection(UserModel.tableName)
              .doc(uid)
              .snapshots()
              .listen((event) {
            if (event.exists) {
              final model = UserModel.fromMap(event.data()!);
              isActive = model.isActive;

              return;
            }
            update();
          });
          threads.add(threadModel);
        }
      }
      messagesList = [];
      messagesList = threads;
      isLoading = false;
      update();
    });
  }

  void deleteThread(String id) {
    AppDialog.customOpenSetttingDialog(
        openSetting: () async {
          Get.back();
          BaseController.showProgress();
          await FirebaseFirestore.instance
              .collection(ThreadModel.tableName)
              .doc(id)
              .collection(ChatModel.tableName)
              .get()
              .then((value) {
            for (var ds in value.docs) {
              ds.reference.delete();
            }
          });
          await FirebaseFirestore.instance
              .collection(ThreadModel.tableName)
              .doc(id)
              .delete();
          BaseController.hideProgress();
          update();
        },
        title: "Are you sure!",
        cancel: "No",
        onOk: "Ok",
        message: "Do you really want delete chat");
  }
}
