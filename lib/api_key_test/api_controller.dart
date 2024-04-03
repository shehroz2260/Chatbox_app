import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/controllers/base_controller.dart';

class ApiController extends GetxController {
  Map<String, dynamic> data = {};
  int statusCode = 0;
  String result = '';
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      data = {};
      statusCode = 0;
      result = "";
      update();
      performOcr(File(res.path), "785cb822-c17d-40b4-865d-dd75da364ffc");
    }
  }

  Future<void> performOcr(File imagePath, String modelId) async {
    BaseController.showProgress();
    try {
      String url =
          "https://app.nanonets.com/api/v2/OCR/Model/$modelId/LabelFile/?async=false";
      final apiKey =
          'Basic ${base64Encode(utf8.encode('c0a4a1f0-f0c6-11ee-a3a9-caf5a484f7c3:'))}';
      final request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers['Authorization'] = apiKey;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imagePath.absolute.path,
      ));
      final responseStream = await request.send();
      final response = await http.Response.fromStream(responseStream);
      BaseController.hideProgress();

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        statusCode = response.statusCode;
        final predictions = data['result'][0]['prediction'];

        for (final prediction in predictions) {
          result += prediction['ocr_text'] + '\n';
        }
      } else {
        BaseController.hideProgress();

        AppDialog.customOkDialogue(
            title: "errror",
            message: 'Failed to perform OCR: ${response.body}');
      }
    } catch (e) {
      BaseController.hideProgress();

      AppDialog.customOkDialogue(
          title: "errror", message: 'Error performing OCR: $e');
    }
    update();
  }
}
