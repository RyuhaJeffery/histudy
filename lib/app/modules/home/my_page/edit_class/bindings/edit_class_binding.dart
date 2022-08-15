import 'package:get/get.dart';

import '../controllers/edit_class_controller.dart';

class EditClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditClassController>(
      () => EditClassController(),
    );
  }
}
