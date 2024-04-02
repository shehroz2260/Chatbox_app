import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:practice_project/services/firebase_storage_service.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/utils/constants.dart';
import 'package:practice_project/view/controllers/base_controller.dart';
import 'package:practice_project/view/main_view/main_view.dart';

class CreateProfileControllere extends GetxController {
  File? pickedFile;
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _qouteController = TextEditingController();
  TextEditingController get addressController => _addressController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get qouteController => _qouteController;
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
        _qouteController.text.isEmpty) {
      AppDialog.customOkDialogue(
          title: "Error", message: "Please Enter something");
      return;
    }
    BaseController.showProgress();
    String? url = "";
    if (pickedFile != null) {
      url = await FirebaseStorageService()
          .uploadFile(pickedFile!, "Profile/image/${Constant.userModel.uid}");
    }
    Constant.userModel = Constant.userModel.copyWith(
      profile: url,
      address: _addressController.text,
      qoute: _qouteController.text,
      phoneNumber: _phoneController.text,
    );
    try {
      await FirebaseFirestore.instance
          .collection(UserModel.tableName)
          .doc(Constant.userModel.uid)
          .set(Constant.userModel.toMap());
      AuthServives().getuserData(uid: Constant.userModel.uid);
      BaseController.hideProgress();
      Get.offAll(() => const MainView());
    } on FirebaseException catch (e) {
      BaseController.hideProgress();
      AppDialog.customOkDialogue(title: "Error", message: e.message);
    }
  }
}
