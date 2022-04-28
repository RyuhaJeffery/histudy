import 'package:get/get.dart';

import '../controllers/group_add_controller.dart';

class GroupAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupAddController>(
      () => GroupAddController(),
    );
  }
}
