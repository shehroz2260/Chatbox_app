import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/services/chat_services.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/utils/media_type.dart';
import 'package:practice_project/controllers/base_controller.dart';

class CreateGroupInfoController extends GetxController {
  File? pickedFile;
  List<String> idList = [];
  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  CreateGroupInfoController(this.idList);
  void imagePicker() async {
    ImagePicker picker = ImagePicker();
    final res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      pickedFile = File(res.path);
      update();
    }
  }

  void createGroupThread() {
    if (_nameController.text.isEmpty || pickedFile == null) {
      AppDialog.customOkDialogue(
          title: "Error", message: "Please filled the required field");
      return;
    }
    BaseController.showProgress();
    ThreadType.threadType = ThreadType.groupChat;
    ChatServices.createNewThread(UserModel.emptyModel, UserModel.emptyModel,
        null, idList, _nameController.text, pickedFile);
  }
}
