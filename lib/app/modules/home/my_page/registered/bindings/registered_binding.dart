import 'package:get/get.dart';

import '../controllers/registered_controller.dart';

class RegisteredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisteredController>(
      () => RegisteredController(),
    );
  }
}
