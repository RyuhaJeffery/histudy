import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';
import '../routes/app_pages.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
Future<DocumentSnapshot> user = _firebaseFirestore
    .collection("Profile")
    .doc(AuthService.to.auth.value.currentUser!.uid).get();

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // print(1);
    User? loggedInUser = await AuthService.to.authCheck();
    // User? loggedInUser = AuthService.to.auth.value.currentUser;
    if (loggedInUser == null) {
      final newRoute = Routes.LOGIN_THEN(route.location!);
      return GetNavConfig.fromRoute(newRoute);
    } else {
      return await super.redirectDelegate(route);
    }
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.auth.value.currentUser != null) {
      return GetNavConfig.fromRoute(Routes.HOME);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureSignUpMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.auth.value.currentUser != null) {
      return GetNavConfig.fromRoute(Routes.HOME);
    }
    return await super.redirectDelegate(route);
  }
}
