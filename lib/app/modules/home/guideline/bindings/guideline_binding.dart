import 'package:get/get.dart';

import '../controllers/guideline_controller.dart';

class GuidelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuidelineController>(
      () => GuidelineController(),
    );
  }
}
