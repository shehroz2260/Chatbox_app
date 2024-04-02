import 'package:get/get.dart';
import 'package:practice_project/view/onboarding_view/auth_view/login_view/login_view.dart';
import 'package:practice_project/view/onboarding_view/auth_view/signup_view/signup_view.dart';

class WelcomeController extends GetxController {
  void onLogin() {
    Get.to(() => const LoginView());
  }

  void onSignUp() {
    Get.to(() => const SignUpView());
  }
}
