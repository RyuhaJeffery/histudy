import 'package:get/get.dart';

import '../controllers/announce_controller.dart';

class AnnounceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnnounceController>(
      () => AnnounceController(),
    );
  }
}
