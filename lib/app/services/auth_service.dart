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
    //authCheck();
    super.onInit();
  }

  // Future<User?> authCheck() async {
  //   print("authCheck function is executed\n");
  //   User? user = await auth.value.authStateChanges().first;
  //   return user;
  // }

  //구글 로그인을 통해 로그인을 하는 코드이다.
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await auth.value.signInWithCredential(credential);
    // print(auth.value.currentUser);
    // print(auth.value.currentUser!.email);
    // if(auth.value.currentUser!=null){
    //   print("\n\nSuccessfully logined, your current user is\n${auth.value.currentUser}");
    // }
  }

//구글 로그인에서 로그아웃 할때 설정해주었던 모든 것들을 다시 초기화 시켜주는 작업도 함께 해준다.
  void googleSignOut() async {
    if (auth.value.currentUser != null) {
      print(
          "before sign out: " + auth.value.currentUser!.displayName.toString());
    } else {
      print("No Auth");
      return;
    }
    await _googleSignIn.signOut();
    await auth.value.signOut();
    print("User Sign Out");
  }
}
