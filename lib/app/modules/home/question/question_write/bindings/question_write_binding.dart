import 'package:get/get.dart';

import '../controllers/question_write_controller.dart';

class QuestionWriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionWriteController>(
      () => QuestionWriteController(),
    );
  }
}
