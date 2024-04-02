import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/firebase_storage_service.dart';
import 'package:practice_project/utils/app_functions.dart';
import 'package:practice_project/utils/media_type.dart';
import 'package:practice_project/view/controllers/base_controller.dart';
import 'package:practice_project/view/main_view/main_view.dart';
import '../models/chat_model.dart';
import '../models/thread_model.dart';
import '../models/user_model.dart';

class ChatServices {
  static String threadId = "";

  static Future<void> createNewThread(
      UserModel recieverModel,
      UserModel senderModel,
      String? message,
      List<String> idLsit,
      String groupName,
      File? groupImage) async {
    threadId = ThreadType.threadType == ThreadType.groupChat
        ? AppFunction.generateRandomString(15)
        : createThreadId(senderModel.uid, recieverModel.uid);
    var snapShot = await FirebaseFirestore.instance
        .collection(ThreadModel.tableName)
        .doc(threadId)
        .get();
    if (snapShot.exists) return;
    String? url = "";
    if (ThreadType.threadType == ThreadType.groupChat && groupImage != null) {
      url = await FirebaseStorageService()
          .uploadFile(groupImage, "GroupImage/$threadId");
    }
    var thread = ThreadModel(
      groupImage: url ?? "",
      threadType: ThreadType.threadType,
      groupName: groupName,
      isBlocked: false,
      isPending: false,
      lastMessage: message ?? "",
      lastMessageTime: DateTime.now(),
      participantUserList: ThreadType.threadType == ThreadType.groupChat
          ? idLsit
          : [recieverModel.uid, senderModel.uid],
      messageCount: 0,
      senderId: '',
      threadId: threadId,
    );

    await FirebaseFirestore.instance
        .collection(ThreadModel.tableName)
        .doc(threadId)
        .set({...thread.toMap(), "isPending": message == null ? false : true},
            SetOptions(merge: true));

    if (ThreadType.threadType == ThreadType.groupChat) {
      BaseController.hideProgress();
      Get.off(const MainView());
    }
    if (message == null) {
      return;
    }
    ChatModel chatModel = ChatModel(
      id: AppFunction.generateRandomString(10),
      senderId: senderModel.uid,
      lastMessageTime: thread.lastMessageTime,
      message: thread.lastMessage,
      messageTime: DateTime.now(),
      media: MediaModel(
          type: 0,
          id: AppFunction.generateRandomString(10),
          url: "url",
          createdAt: DateTime.now(),
          name: "name"),
    );

    await FirebaseFirestore.instance
        .collection(ThreadModel.tableName)
        .doc(threadId)
        .collection(ChatModel.tableName)
        .doc(chatModel.id)
        .set(chatModel.toMap(), SetOptions(merge: true));
  }

  static String createThreadId(String s1, String s2) {
    return s1.compareTo(s2) >= 0 ? "${s1}__$s2" : "${s2}__$s1";
  }
}
