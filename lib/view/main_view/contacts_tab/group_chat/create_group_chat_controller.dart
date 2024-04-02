import 'package:get/get.dart';
import 'package:practice_project/models/user_model.dart';
import 'package:practice_project/utils/constants.dart';

class CreateGroupController extends GetxController {
  List<String> participantID = [];
  List<UserModel> selectedUserList = [];
  void selectUser(List<UserModel> users, int index) {
    users[index] = users[index].copyWith(isSelect: !users[index].isSelect);
    selectedUserList =
        users.where((element) => element.isSelect == true).toList();
    update();
    if (users[index].isSelect == true) {
      participantID.add(users[index].uid);
    } else {
      participantID.remove(users[index].uid);
    }
    participantID.addIf(!participantID.contains(Constant.userModel.uid),
        Constant.userModel.uid);
    update();
  }
}
