import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/utils/app_strings.dart';

class SignUpController extends GetxController {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _cPasswordController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get nameController => _nameController;
  TextEditingController get cPasswordController => _cPasswordController;
  bool buttonDisable() {
    return (_emailController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _cPasswordController.text.isEmpty);
  }

  void onEmailChnaged(String value) {
    update();
  }

  void onNameChnaged(String value) {
    update();
  }

  void onCPasswordChnaged(String value) {
    update();
  }

  void onPasswordChnaged(String value) {
    update();
  }

  void signup() {
    if (buttonDisable()) {
      AppDialog.customOkDialogue(
          title: ErrorString.error, message: "Please enter field");
      return;
    }
    if (_passwordController.text != _cPasswordController.text) {
      AppDialog.customOkDialogue(
          title: ErrorString.error, message: "Please enter same password");
      return;
    }
    AuthServives().signUpWithEmailorPassword(
        _emailController.text, _passwordController.text, _nameController.text);
  }
}
