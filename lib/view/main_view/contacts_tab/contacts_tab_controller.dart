import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:practice_project/models/user_model.dart';
import '../../../controllers/admin_base_controller.dart';

class ContactTabController extends GetxController {
  bool isLoading = false;
  Map<String, List<UserModel>> categorizedNames = {};
  String letter = "";
  List<UserModel> contactList = [];
  Map<String, List<UserModel>> groupNamesByFirstLetter(
      List<UserModel> usersList) {
    Map<String, List<UserModel>> groupedNames = {};
    for (final user in usersList) {
      String firstLetter = user.name.substring(0, 1).toUpperCase();
      if (!groupedNames.containsKey(firstLetter)) {
        groupedNames[firstLetter] = [];
      }
      groupedNames[firstLetter]!.add(user);
    }

    update();
    return groupedNames;
  }

  @override
  void onInit() {
    getContact();

    super.onInit();
  }

  Future<void> getContact() async {
    isLoading = true;
    update();
    FirebaseFirestore.instance
        .collection("UserModel.tableName")
        .snapshots()
        .listen((snap) {
      if (snap.docs.isNotEmpty) {
        contactList.clear();
        for (final e in snap.docs) {
          final model = UserModel.fromMap(e.data());
          contactList.addIf(
              model.uid != AdminBaseController.userData.uid, model);
        }
        categorizedNames = groupNamesByFirstLetter(contactList);
        isLoading = false;
        update();
      }
    });
  }
}
