import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/api_key_test/api_controller.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/widgets/custom_button.dart';

class ApiKeyTest extends StatelessWidget {
  const ApiKeyTest({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApiController());
    return Scaffold(
      body: GetBuilder<ApiController>(builder: (context) {
        return Column(
          children: [
            AppGap.height70,
            CustomButton(
              buttonColor: AppColors.greenColor,
              textColor: AppColors.appBgColor,
              name: "picker",
              onTap: () => controller.pickImage(),
            ),
            AppGap.height16,
            Text("StatusCode: ${controller.statusCode}"),
            AppGap.height16,
            Text("OCR Text: ${controller.result}"),
            AppGap.height16,
            Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Data: ${controller.data}")))
          ],
        );
      }),
    );
  }
}
