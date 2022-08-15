import 'package:get/get.dart';

import '../controllers/edit_sem_controller.dart';

class EditSemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditSemController>(
      () => EditSemController(),
    );
  }
}
