import 'package:get/get.dart';

import '../controllers/question_detail_controller.dart';

class QuestionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionDetailController>(
      () => QuestionDetailController(),
    );
  }
}
