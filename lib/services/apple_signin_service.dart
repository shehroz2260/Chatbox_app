import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_project/services/auth_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../utils/app_dialog.dart';
import '../view/controllers/base_controller.dart';

class AppleSignService {
  //////////////////////////////////////////////////////////////
  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // / Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    try {
      BaseController.showProgress();
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
        rawNonce: rawNonce,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      await AuthServives().checkUserExists();
    } on SignInWithAppleException {
      BaseController.hideProgress();
      AppDialog.customOkDialogue(title: "Error", message: "Sign in failed");
    } on FirebaseAuthException catch (e) {
      BaseController.hideProgress();
      AppDialog.customOkDialogue(title: "Error", message: e.message);
    } on FirebaseException catch (e) {
      BaseController.hideProgress();
      AppDialog.customOkDialogue(title: "Error", message: e.message);
    }
  }
}
