import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/view/controllers/admin_base_controller.dart';
import '../utils/app_dialog.dart';

class ThreadModel {
  final String lastMessage;
  final DateTime lastMessageTime;
  final List<dynamic> participantUserList;
  final String senderId;
  final int messageCount;
  final String threadId;
  UserModel? userDetail;
  final bool isPending;
  final bool isBlocked;
  final String groupImage;
  final String groupName;
  final int threadType;
  static const String tableName = "threads";
  ThreadModel({
    required this.lastMessage,
    required this.lastMessageTime,
    required this.participantUserList,
    required this.senderId,
    required this.messageCount,
    required this.groupImage,
    required this.threadType,
    required this.groupName,
    required this.threadId,
    this.userDetail,
    required this.isPending,
    required this.isBlocked,
  });

  ThreadModel copyWith({
    String? lastMessage,
    DateTime? lastMessageTime,
    List<dynamic>? participantUserList,
    String? senderId,
    int? messageCount,
    String? threadId,
    UserModel? userDetail,
    bool? isPending,
    bool? isBlocked,
    int? threadType,
    String? groupImage,
    String? groupName,
    String? id,
  }) {
    return ThreadModel(
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      participantUserList: participantUserList ?? this.participantUserList,
      senderId: senderId ?? this.senderId,
      messageCount: messageCount ?? this.messageCount,
      threadId: threadId ?? this.threadId,
      userDetail: userDetail ?? this.userDetail,
      isPending: isPending ?? this.isPending,
      isBlocked: isBlocked ?? this.isBlocked,
      groupImage: groupImage ?? this.groupImage,
      threadType: threadType ?? this.threadType,
      groupName: groupName ?? this.groupName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastMessage': lastMessage,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'participantUserList': participantUserList,
      'senderId': senderId,
      'messageCount': messageCount,
      'threadId': threadId,
      'userDetail': userDetail?.toMap(),
      'isPending': isPending,
      'threadType': threadType,
      "groupName": groupName,
      'groupImage': groupImage,
      'isBlocked': isBlocked,
    };
  }

  factory ThreadModel.fromMap(Map<String, dynamic> map) {
    return ThreadModel(
      lastMessage: map['lastMessage'] ?? "",
      groupImage: map['groupImage'] ?? "",
      groupName: map['groupName'] ?? "",
      lastMessageTime: (map['lastMessageTime'] as Timestamp).toDate(),
      participantUserList:
          List<dynamic>.from((map['participantUserList'] as List<dynamic>)),
      senderId: map['senderId'] ?? "",
      messageCount: map['messageCount'] ?? 0,
      threadId: map['threadId'] ?? "",
      userDetail: map['userDetail'] != null
          ? UserModel.fromMap(map['userDetail'] as Map<String, dynamic>)
          : null,
      isPending: map['isPending'] ?? false,
      isBlocked: map['isBlocked'] ?? false,
      threadType: map['threadType'] ?? 0,
    );
  }
  void readMessage() async {
    try {
      if (senderId != AdminBaseController.userData.uid) {
        await FirebaseFirestore.instance
            .collection(tableName)
            .doc(threadId)
            .update({'messageCount': 0});
      }
    } on FirebaseException catch (e) {
      AppDialog.customOkDialogue(title: "Error", message: e.message);
    }
  }

  @override
  String toString() {
    return 'ThreadModel(lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, participantUserList: $participantUserList, senderId: $senderId, messageCount: $messageCount, threadId: $threadId, userDetail: $userDetail, isPending: $isPending, isBlocked: $isBlocked, isGroup: $threadType, groupImage: $groupImage , groupName: $groupName)';
  }
}
