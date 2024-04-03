import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/view/controllers/admin_base_controller.dart';
import 'package:practice_project/view/controllers/base_controller.dart';

class EditProfileController extends GetxController {
  final _fieldController = TextEditingController();
  TextEditingController get fieldController => _fieldController;

  void updateName() async {
    BaseController.showProgress();
    UserModel userModel = AdminBaseController.userData;
    userModel = userModel.copyWith(name: _fieldController.text);
    AdminBaseController.updateUser(userModel);
    userModel.updateorAddUser();
    BaseController.hideProgress();
    Get.back();
  }

  void updateAddress() async {
    BaseController.showProgress();
    UserModel userModel = AdminBaseController.userData;
    userModel = userModel.copyWith(address: _fieldController.text);
    AdminBaseController.updateUser(userModel);
    userModel.updateorAddUser();
    BaseController.hideProgress();
    Get.back();
  }

  void updatePhone() async {
    BaseController.showProgress();
    UserModel userModel = AdminBaseController.userData;
    userModel = userModel.copyWith(phoneNumber: _fieldController.text);
    AdminBaseController.updateUser(userModel);
    userModel.updateorAddUser();
    BaseController.hideProgress();
    Get.back();
  }

  void updateStatus() async {
    BaseController.showProgress();
    UserModel userModel = AdminBaseController.userData;
    userModel = userModel.copyWith(status: _fieldController.text);
    AdminBaseController.updateUser(userModel);
    userModel.updateorAddUser();
    BaseController.hideProgress();
    Get.back();
  }
}
