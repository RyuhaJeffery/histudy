import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController {
  //TODO: Implement MyPageController


 var form_enabled =false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  changed_enabled(){
    form_enabled =true.obs;
    update();
    print(form_enabled);
  }
  @override
  void onClose() {}
  void increment() => count.value++;
}
