import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_dialog.dart';
import 'package:practice_project/utils/app_strings.dart';
import 'package:practice_project/view/main_view/call_tab/call_tab_controller.dart';
import 'package:practice_project/view/main_view/contacts_tab/contacts_tab_controller.dart';
import 'package:practice_project/view/main_view/message_tab/message_tab_controller.dart';
import 'package:practice_project/view/main_view/setting_tab/setting_tab_controller.dart';
import 'package:practice_project/view/onboarding_view/auth_view/signup_view/create_profile/create_profile_view.dart';
import 'package:practice_project/view/onboarding_view/welcome_view/welcome_view.dart';
import '../models/user_model.dart';
import '../view/controllers/admin_base_controller.dart';
import '../view/controllers/base_controller.dart';
import '../view/main_view/main_view.dart';

class AuthServives {
  final auth = FirebaseAuth.instance;
  UserCredential? userdata;

  Future<void> signUpWithEmailorPassword(
      String email, String password, String name) async {
    BaseController.showProgress();
    userdata = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    auth.currentUser!.sendEmailVerification();
    UserModel userModel = UserModel(
        phoneNumber: "",
        uid: auth.currentUser!.uid,
        email: email,
        name: name,
        profile: "",
        address: "",
        status: "");
    AdminBaseController.updateUser(userModel);
    userModel.updateorAddUser();

    BaseController.hideProgress();
    Get.offAll(() => const WelcomeView());
    AppDialog.customOkDialogue(
        title: "Verification Email",
        message:
            "Verification email sent to your email please check your mail");
  }

  Future signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      BaseController.showProgress();
      userdata = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (!auth.currentUser!.emailVerified) {
        AppDialog.customOkDialogue(
            title: "Error", message: "Email is not verified check your email!");

        return;
      }

      await checkUserExists();
    } on FirebaseAuthException catch (e) {
      BaseController.hideProgress();
      AppDialog.customOkDialogue(title: "Error", message: e.message);
    }
  }

  Future<void> checkUserExists() async {
    await getuserData(uid: auth.currentUser!.uid);
    if (AdminBaseController.userData.uid.isEmpty ||
        AdminBaseController.userData.email.isEmpty ||
        AdminBaseController.userData.name.isEmpty) {
      UserModel userModel = UserModel(
          uid: auth.currentUser!.uid,
          email: auth.currentUser?.email ?? "",
          name: auth.currentUser?.displayName ?? "",
          profile: "",
          address: "",
          phoneNumber: "",
          status: "");
      AdminBaseController.updateUser(userModel);
      userModel.updateorAddUser();
      BaseController.hideProgress();
      Get.offAll(() => const CreateProfileView());
    }
    if (!auth.currentUser!.emailVerified) {
      BaseController.hideProgress();
      signout();
      AppDialog.customOkDialogue(
          title: ErrorString.error, message: ErrorString.emailNotVerified);
      return;
    }
    if (AdminBaseController.userData.phoneNumber.isEmpty ||
        AdminBaseController.userData.profile.isEmpty ||
        AdminBaseController.userData.address.isEmpty ||
        AdminBaseController.userData.status.isEmpty) {
      BaseController.hideProgress();
      Get.offAll(() => const CreateProfileView());
      return;
    }
    Get.put(MessageTabController(), permanent: true);
    Get.put(CallTabController(), permanent: true);
    Get.put(ContactTabController(), permanent: true);
    Get.put(SettingTabController(), permanent: true);

    BaseController.hideProgress();
    Get.offAll(() => const MainView());
  }

  Future getUserById({required String uid}) async {
    UserModel? model;
    try {
      var value = await FirebaseFirestore.instance
          .collection(UserModel.tableName)
          .doc(uid)
          .get();
      if (value.exists) {
        model = UserModel.fromMap(value.data()!);
      }

      return model;
    } on FirebaseException catch (e) {
      AppDialog.customOkDialogue(title: ErrorString.error, message: e.message);
      return model;
    }
  }

  static Future<UserModel?> getuserData({required String uid}) async {
    if (AdminBaseController.getUser(uid) != null) {
      return AdminBaseController.getUser(uid);
    }
    UserModel? userModel;
    try {
      var snapShot = await FirebaseFirestore.instance
          .collection(UserModel.tableName)
          .doc(uid)
          .get();
      if (!snapShot.exists) return null;
      userModel = UserModel.fromMap(snapShot.data() ?? {});
      if (userModel.uid == (FirebaseAuth.instance.currentUser?.uid ?? "")) {
        AdminBaseController.updateUser(userModel);
      } else {
        AdminBaseController.addUser(userModel);
      }
    } on FirebaseException catch (e) {
      AppDialog.customOkDialogue(title: "Error", message: e.message);
    }

    return userModel;
  }

  Future<void> signout() async {
    await auth.signOut();
    if (auth.currentUser != null) return;
    Get.deleteAll();
    AdminBaseController().userModel = UserModel.emptyModel;
    Get.offAll(const WelcomeView());
  }
}
