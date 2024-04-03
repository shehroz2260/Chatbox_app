import 'package:get/get.dart';
import '../models/user_model.dart';

class AdminBaseController extends GetxController {
  static final _userController =
      Get.put(AdminBaseController(), permanent: true);

  UserModel userModel = UserModel.emptyModel;
  Map<String, UserModel> users = {};

  static bool isContains(String uid) {
    return _userController.users[uid] != null;
  }

  static void addUser(UserModel userModel) {
    _userController.users[userModel.uid] = userModel;
  }

  static UserModel? getUser(String uid) {
    return _userController.users[uid];
  }

  static void updateUser(UserModel userModel) {
    _userController.userModel = userModel;
    _userController.update();
  }

  static UserModel get userData {
    return _userController.userModel;
  }
}
