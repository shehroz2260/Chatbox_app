import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/services/firebase_storage_service.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/view/controllers/admin_base_controller.dart';
import 'package:practice_project/view/controllers/base_controller.dart';
import 'package:practice_project/view/main_view/main_view.dart';

class CreateProfileControllere extends GetxController {
  File? pickedFile;
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _statusController = TextEditingController();
  TextEditingController get addressController => _addressController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get statusController => _statusController;
  void imagePicker(bool camera) async {
    ImagePicker picker = ImagePicker();
    final res = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery);
    if (res != null) {
      pickedFile = File(res.path);
      update();
    }
  }

  Future<void> saveData() async {
    if (_addressController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        pickedFile == null ||
        _statusController.text.isEmpty) {
      AppDialog.customOkDialogue(
          title: "Error", message: "Please Enter something");
      return;
    }
    BaseController.showProgress();
    String? url = "";
    if (pickedFile != null) {
      url = await FirebaseStorageService().uploadFile(
          pickedFile!, "Profile/image/${AdminBaseController.userData.uid}");
    }
    UserModel userModel = AdminBaseController.userData.copyWith(
      profile: url,
      address: _addressController.text,
      status: _statusController.text,
      phoneNumber: _phoneController.text,
    );
    try {
      AdminBaseController.updateUser(userModel);
      userModel.updateorAddUser();
      BaseController.hideProgress();
      Get.offAll(() => const MainView());
    } on FirebaseException catch (e) {
      BaseController.hideProgress();
      AppDialog.customOkDialogue(title: "Error", message: e.message);
    }
  }
}
