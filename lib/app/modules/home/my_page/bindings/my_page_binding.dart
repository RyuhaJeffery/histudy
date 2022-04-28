import 'package:get/get.dart';

import '../controllers/my_page_controller.dart';

class MyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageController>(
      () => MyPageController(),
    );
  }
}
