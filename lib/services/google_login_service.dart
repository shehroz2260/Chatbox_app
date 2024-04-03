import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_project/services/auth_service.dart';
import '../controllers/base_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginService {
  static Future<void> signInWithGoogle() async {
    BaseController.showProgress();
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(credential);
        await AuthServives().checkUserExists();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
      } else if (e.code == 'invalid-credential') {}
    }
    BaseController.hideProgress();
  }
}
