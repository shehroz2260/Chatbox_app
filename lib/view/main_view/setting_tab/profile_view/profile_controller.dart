import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/services/firebase_storage_service.dart';
import 'package:practice_project/view/controllers/admin_base_controller.dart';
import 'package:practice_project/view/controllers/base_controller.dart';

class ProfileController extends GetxController {
  void changeProfileImage() async {
    ImagePicker picker = ImagePicker();
    BaseController.showProgress();
    final res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      final url = await FirebaseStorageService().uploadFile(
          File(res.path), "Profile/image/${AdminBaseController.userData.uid}");
      UserModel userModel = AdminBaseController.userData.copyWith(profile: url);
      AdminBaseController.updateUser(userModel);
      userModel.updateorAddUser();
      BaseController.hideProgress();
    }
  }
}
