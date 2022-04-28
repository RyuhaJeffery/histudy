import 'package:get/get.dart';

import '../controllers/group_del_controller.dart';

class GroupDelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupDelController>(
      () => GroupDelController(),
    );
  }
}
