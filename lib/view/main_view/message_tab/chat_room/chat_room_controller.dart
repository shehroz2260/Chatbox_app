import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice_project/services/firebase_storage_service.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/utils/media_type.dart';
import 'package:practice_project/view/controllers/base_controller.dart';
import '../../../../models/chat_model.dart';
import '../../../../models/thread_model.dart';
import '../../../../utils/app_dialog.dart';
import '../../../../utils/app_functions.dart';
import '../../../controllers/admin_base_controller.dart';

class ChatRoomController extends GetxController {
  String threadId = "";
  ScrollController scrollController = ScrollController();
  bool isSending = false;
  bool isRecording = false;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastMessageDocument;
  List<ChatModel> messageList = [];
  File? pickedFile;
  File? thumbnail;
  final chatController = TextEditingController();
  ChatRoomController(this.threadId);
  ThreadModel? threadModel;
  int lastCount = 20;
  bool isLoading = false;
  String? files;
  String pickedFileName = "";
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? threadSubSc;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? loadChatSub;
  /////////////////////////////////////////////////  init state //////////////////////////////////////////////////////////////
  @override
  void onInit() async {
    loadthreadModel();
    scrollController.addListener(onScroll);
    await loadChat();
    attachMessagesListener();
    update();
    super.onInit();
  }

  @override
  void onClose() async {
    await threadSubSc?.cancel();
    await loadChatSub?.cancel();
    super.onClose();
  }

  /////////////////////////////////////////////////  Others Functions //////////////////////////////////////////////////////////////
  bool showTime(int index) {
    if (index == messageList.length - 1) return true;
    if (messageList[index].lastMessageTime == null ||
        messageList[index + 1].lastMessageTime == null) return false;
    return messageList[index]
            .lastMessageTime!
            .difference(messageList[index + 1].lastMessageTime!)
            .inHours >
        1;
  }

  void onbuttonChanged(string) {
    update();
  }

  void clearPickedValue() {
    pickedFile = null;
    thumbnail = null;
    files = null;
    update();
  }

  bool buttonDisable() {
    return chatController.text.isEmpty &&
        pickedFile == null &&
        thumbnail == null &&
        files == null;
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadChat();
    }
  }

  /////////////////////////////////////////////////  Open Files //////////////////////////////////////////////////////////////

  Future<String> downloadFile(String url, String filename) async {
    if (kIsWeb) {
      return url;
    }
    BaseController.showProgress();
    String dir = (await getTemporaryDirectory()).path;
    File targetFile = File('$dir/$filename');
    final httpClient = Client();
    var request = await httpClient.get(Uri.parse(url));
    var response = request.bodyBytes;
    await targetFile.writeAsBytes(response);
    BaseController.hideProgress();
    return targetFile.path;
  }

  /////////////////////////////////////////////////  Load Thread //////////////////////////////////////////////////////////////
  Future<void> loadthreadModel() async {
    threadSubSc = FirebaseFirestore.instance
        .collection(ThreadModel.tableName)
        .doc(threadId)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        threadModel = ThreadModel.fromMap(event.data() ?? {});
        if (threadModel != null) threadModel?.readMessage();
      }
    });
  }

  ///////////////////////////////////////////////// files pickers  //////////////////////////////////////////////////////////////
  void pickImage(bool isCamera, bool isVideo) async {
    ImagePicker picker = ImagePicker();
    final res = isVideo
        ? await picker.pickVideo(
            source: isCamera ? ImageSource.camera : ImageSource.gallery)
        : await picker.pickImage(
            source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (res != null) {
      pickedFile = File(res.path);
      MediaType.mediaType = isVideo ? MediaType.video : MediaType.image;
      pickedFileName = res.name;
      update();
    }
    if (isVideo && res != null) {
      XFile thumbnailFile = await VideoThumbnail.thumbnailFile(
        video: pickedFile!.path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 64,
        quality: 75,
      );
      thumbnail = File(thumbnailFile.path);
      update();
    }
  }

  void pickFile() async {
    final results = await FilePicker.platform.pickFiles();
    if (results != null && results.files.isNotEmpty) {
      MediaType.mediaType = MediaType.file;
      files = results.files.first.path;
      pickedFileName = results.files.first.name;
      update();
    }
  }

  /////////////////////////////////////////////////  Load Messages //////////////////////////////////////////////////////////////
  Future<void> loadChat() async {
    if (lastCount < 20) {
      return;
    }
    isLoading = true;
    update();
    Query<Map<String, dynamic>> snapShotQuery;
    snapShotQuery = FirebaseFirestore.instance
        .collection(ThreadModel.tableName)
        .doc(threadId)
        .collection(ChatModel.tableName)
        .orderBy("messageTime", descending: true)
        .limit(20);
    if (lastMessageDocument != null) {
      snapShotQuery = snapShotQuery.startAfterDocument(lastMessageDocument!);
    }
    var snapShot = await snapShotQuery.get();
    var messagesLIsts = snapShot.docs.map((e) {
      lastMessageDocument = e;
      return ChatModel.fromMap(e.data());
    }).toList();
    lastCount = messagesLIsts.length;
    log("last cpdcsidft  ${lastCount.toString()}");
    messageList.addAll(messagesLIsts);
    isLoading = false;
    update();
  }

  void attachMessagesListener() async {
    final ref = FirebaseFirestore.instance
        .collection(ThreadModel.tableName)
        .doc(threadId)
        .collection(ChatModel.tableName)
        .orderBy("messageTime", descending: true)
        .limit(1);

    loadChatSub = ref.snapshots().listen((event) {
      if (event.docs.isEmpty) return;
      if (kDebugMode) {}
      var chat = ChatModel.fromMap(event.docs[0].data());

      if (messageList.firstWhereOrNull((element) => element.id == chat.id) !=
          null) return;
      if (kDebugMode) {}
      if (messageList.isEmpty) {
        if (kDebugMode) {}
        messageList.insert(0, chat);

        update();
        return;
      }
      messageList.insert(0, chat);
      update();
    });
  }

  /////////////////////////////////////////////////  Send Messages //////////////////////////////////////////////////////////////
  void sendMessage() async {
    var id = AppFunction.generateRandomString(15);
    if (buttonDisable()) {
      AppDialog.customOkDialogue(
          title: "Error", message: "Please enter a message or media");
      return;
    }
    isSending = true;
    update();
    String? url;
    String? thumb;
    if (pickedFile != null && MediaType.mediaType == MediaType.image) {
      url = await FirebaseStorageService().uploadFile(pickedFile!,
          "chatimage/${AdminBaseController.userData.uid}/${AppFunction.generateRandomString(10)}");
    }
    if (pickedFile != null && MediaType.mediaType == MediaType.video) {
      url = await FirebaseStorageService().uploadVideo(pickedFile!,
          "chatVideo/${AdminBaseController.userData.uid}/${AppFunction.generateRandomString(10)}");
      thumb = await FirebaseStorageService().uploadFile(thumbnail!,
          "chatVideoThumbnail/${AdminBaseController.userData.uid}/${AppFunction.generateRandomString(10)}");
    }
    if (files != null && MediaType.mediaType == MediaType.file) {
      url = await FirebaseStorageService().uploadFiles(files!,
          "ChatFiles/${AdminBaseController.userData.uid}/${AppFunction.generateRandomString(10)}");
    }
    ChatModel chatModel = ChatModel(
        id: id,
        message: chatController.text,
        senderId: AdminBaseController.userData.uid,
        messageTime: DateTime.now(),
        lastMessageTime: DateTime.now(),
        profileImae: AdminBaseController.userData.profile,
        media: url == null
            ? null
            : MediaModel(
                type: MediaType.mediaType,
                id: AppFunction.generateRandomString(15),
                url: url,
                thumbnail: thumb,
                createdAt: DateTime.now(),
                name: pickedFileName));

    try {
      await FirebaseFirestore.instance
          .collection(ThreadModel.tableName)
          .doc(threadId)
          .collection(ChatModel.tableName)
          .doc(id)
          .set(chatModel.toMap(), SetOptions(merge: true));
      await FirebaseFirestore.instance
          .collection(ThreadModel.tableName)
          .doc(threadId)
          .update({
        'lastMessage': chatController.text,
        'lastMessageTime': DateTime.now(),
        'messageCount':
            threadModel?.senderId != AdminBaseController.userData.uid
                ? 1
                : (threadModel?.messageCount ?? 0) + 1,
        'senderId': AdminBaseController.userData.uid,
      });
      chatController.clear();
      pickedFile = null;
      isSending = false;
      thumbnail = null;
      files = null;
      update();
    } on FirebaseException catch (e) {
      AppDialog.customOkDialogue(title: ErrorString.error, message: e.message);
    }
  }
}
