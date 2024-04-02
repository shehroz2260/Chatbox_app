import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:resize/resize.dart';

class AppDialog {
  static void customOkDialogue({required String title, String? message}) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.only(bottom: 15, top: 5),
      title: Center(
          child: Text(
        title,
        style: TextStyle(
            fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w600),
      )),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          message!,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        const Divider(
          thickness: .5,
          height: 0.5,
          color: AppColors.greenColor,
        ),
        const SizedBox(height: 10),
        Center(
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              height: 30,
              width: 70,
              child: const Text(
                "Ok",
                style: TextStyle(color: AppColors.appBgColor, fontSize: 14),
              ),
            ),
          ),
        )
      ],
    ));
  }

  static void customOpenSetttingDialog(
      {required void Function() openSetting,
      required String title,
      required String cancel,
      required String onOk,
      required String message}) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.only(bottom: 15, top: 5),
      title: Center(
          child: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      )),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          message,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        const Divider(
          thickness: .5,
          height: 0.5,
          color: AppColors.greenColor,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  height: 30,
                  child: Text(
                    cancel,
                    style: const TextStyle(
                        color: AppColors.appBgColor, fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: openSetting,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  height: 30,
                  child: Text(
                    onOk,
                    style: const TextStyle(
                        color: AppColors.appBgColor, fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    ));
  }
}
