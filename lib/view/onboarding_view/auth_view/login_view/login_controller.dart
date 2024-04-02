import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/utils/app_strings.dart';

class LoginController extends GetxController {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool buttonDisable() {
    return (_emailController.text.isEmpty || _passwordController.text.isEmpty);
  }

  void onEmailChnaged(String value) {
    update();
  }

  void onPasswordChnaged(String value) {
    update();
  }

  void login() {
    if (buttonDisable()) {
      AppDialog.customOkDialogue(
          title: ErrorString.error, message: 'Please Enter field');
      return;
    }
    AuthServives().signInWithEmailPassword(
        email: _emailController.text, password: _passwordController.text);
  }
}
