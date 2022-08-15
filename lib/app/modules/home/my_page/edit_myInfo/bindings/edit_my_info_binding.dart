import 'package:get/get.dart';

import '../controllers/edit_my_info_controller.dart';

class EditMyInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMyInfoController>(
      () => EditMyInfoController(),
    );
  }
}
