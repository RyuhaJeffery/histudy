import 'dart:html';

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
  //TODO: implement EnsureSignUpMiddleware
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.auth.value.currentUser != null) {
      return GetNavConfig.fromRoute(Routes.HOME);
    }
    return await super.redirectDelegate(route);
  }
}

class EnsureAdminMiddleware extends GetMiddleware {
  @override
  //TODO: implement EnsureAdminMiddleware
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    user.get().then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      print(data['isAdmin']);
      if(data['isAdmin'] == true){
        return GetNavConfig.fromRoute(Routes.ADMIN);
      }
    });
    return await super.redirectDelegate(route);
  }
}
