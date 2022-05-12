import 'package:get/get.dart';
import 'package:histudy/app/services/auth_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    // if(AuthService.to.auth.value.currentUser!=null){
    //   print("\n\nSuccessfully logined, your current user is\n${AuthService.to.auth.value.currentUser}");
    // }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
