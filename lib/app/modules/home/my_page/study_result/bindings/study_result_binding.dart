import 'package:get/get.dart';

import '../controllers/study_result_controller.dart';

class StudyResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudyResultController>(
      () => StudyResultController(),
    );
  }
}
