import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../routes/app_pages.dart';

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
