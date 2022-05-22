import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../models/profile_model.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  User? currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  Rx<FirebaseFirestore> firestore =  FirebaseFirestore.instance.obs;
  @override
  void onInit() {
    authCheck();
    super.onInit();
  }

  Future<User?> authCheck() async {
    print("authCheck function is executed\n");
    User? user = await auth.value.authStateChanges().first;
    return user;
  }

  //구글 로그인을 통해 로그인을 하는 코드이다.
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print("auth_service.dart 33 : Sign in With Google Success!");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print("auth_service.dart 38 : googleAuth assigned");

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await auth.value.signInWithCredential(credential);
    print("auth_service.dart 48 : auth signInWithCredential success");

    //구글 정보가 firestore에 있으면~
    //그냥 로그인이고
    firestore.value.collection('Profile').doc(auth.value.currentUser!.uid).get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists == false) {
        print('\nThere is no current user in firestore\n');
        Get.rootDelegate.toNamed(Routes.SIGN_UP);
      }
    });
      
    
    //없으면 간단한 정보 추가 후 is 어쩌구
  

    Get.rootDelegate.refresh();
  }

//구글 로그인에서 로그아웃 할때 설정해주었던 모든 것들을 다시 초기화 시켜주는 작업도 함께 해준다.
  void googleSignOut() async {
    if (auth.value.currentUser != null) {
      print("auth_service.dart 61 :before sign out: " +
          auth.value.currentUser!.displayName.toString());
    } else {
      print("auth_service.dart 63 :No Auth");
      return;
    }

    await auth.value.signOut();
    print("auth_service.dart 68 : Auth signOut success");

    // await _googleSignIn.signOut();
    // print("auth_service.dart 71 : GoogleSignIn.signOut success!");
  }
}
