import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  @override
  void onInit() {
    super.onInit();
  }
}
