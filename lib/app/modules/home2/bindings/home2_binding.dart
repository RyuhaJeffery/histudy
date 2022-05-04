import 'package:get/get.dart';

import '../controllers/home2_controller.dart';

class Home2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Home2Controller>(
      () => Home2Controller(),
    );
  }
}
