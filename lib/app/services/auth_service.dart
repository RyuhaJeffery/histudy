import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
