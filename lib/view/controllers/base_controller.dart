import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class BaseController {
  Function? onStateChange;
  static bool isAlreadyShow = false;

  BaseController(this.onStateChange);

  void dismissKeyBoard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  static void showProgress() {
    if (isAlreadyShow) {
      return;
    }
    isAlreadyShow = true;
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: AlertDialog(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                titlePadding: EdgeInsets.symmetric(vertical: 15),
                insetPadding: EdgeInsets.zero,
                buttonPadding: EdgeInsets.zero,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                            color: AppColors.greenColor),
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  static void hideProgress() {
    try {
      if (BaseController.isAlreadyShow) {
        BaseController.isAlreadyShow = false;
        Navigator.pop(Get.context!);
      }
    } catch (E) {
      log(E.toString());
    }
  }
}
