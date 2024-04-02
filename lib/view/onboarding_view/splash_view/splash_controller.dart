import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:practice_project/utils/constants.dart';
import 'package:practice_project/view/onboarding_view/welcome_view/welcome_view.dart';

import '../../../models/user_model.dart';

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

  void setOnlineStatus(bool status) async {
    UserModel userModel = Constant.userModel;
    userModel = userModel.copyWith(
      isActive: status,
    );
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance
          .collection(UserModel.tableName)
          .doc(Constant.userModel.uid)
          .set(userModel.toMap(), SetOptions(merge: true));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setOnlineStatus(true);
      update();
    } else {
      setOnlineStatus(false);
      update();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    navigateScreens();
    super.onInit();
  }
}
