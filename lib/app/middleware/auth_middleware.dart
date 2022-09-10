import 'dart:html';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';
import '../routes/app_pages.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
DocumentReference<Map<String, dynamic>> user = _firebaseFirestore
    .collection("Profile")
    .doc(AuthService.to.auth.value.currentUser!.uid);

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    User? loggedInUser = await AuthService.to.authCheck();
    // User? loggedInUser = AuthService.to.auth.value.currentUser;
    if (loggedInUser == null) {
      Get.snackbar(
        "로그인을 해주세요",
        "로그인 후 접속 가능합니다.",
        backgroundColor: Color(0xff04589C),
        colorText: Color(0xffF0F0F0),
      );
      Get.rootDelegate.toNamed(Routes.LOGIN);
      return GetNavConfig.fromRoute(Routes.LOGIN);
    } else {
      return await super.redirectDelegate(route);
    }
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    User? loggedInUser = await AuthService.to.authCheck();
    if (loggedInUser != null) {
      Get.rootDelegate.toNamed(Routes.HOME);
      return GetNavConfig.fromRoute(Routes.HOME);
    } else {
      return await super.redirectDelegate(route);
    }
  }
}

class EnsureSignUpMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    await user.get().then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists == false) {
        Get.snackbar(
          "회원가입이 완료되지 않았습니다.",
          "정보를 모두 입력해주세요!",
          backgroundColor: Color(0xff04589C),
          colorText: Color(0xffF0F0F0),
        );
        return Get.rootDelegate.toNamed(Routes.SIGN_UP);
      } else {
        return await super.redirectDelegate(route);
      }
    });
    return await super.redirectDelegate(route);
  }
}

class EnsureAdminMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    await user.get().then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      print(data['isAdmin']);
      if (data['isAdmin'] == false) {
        return Get.rootDelegate.toNamed(Routes.HOME);
      }
    });
    return await super.redirectDelegate(route);
  }
}

class EnsureRegisterMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    await user.get().then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data['classRegister'] == false) {
        return Get.rootDelegate.toNamed(Routes.REGISTER);
      }
    });
    return await super.redirectDelegate(route);
  }
}
