import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:practice_project/view/onboarding_view/welcome_view/welcome_view.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  Future navigateScreens() async {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => const WelcomeView());
      });
      return;
    }
    if (auth.currentUser != null) {
      AuthServives().checkUserExists();
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    navigateScreens();
    super.onInit();
  }
}
