import 'package:get/get.dart';

import '../controllers/my_page_setting_controller.dart';

class MyPageSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPageSettingController>(
      () => MyPageSettingController(),
    );
  }
}
