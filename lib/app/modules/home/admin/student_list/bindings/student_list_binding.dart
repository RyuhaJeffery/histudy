import 'package:get/get.dart';

import '../controllers/student_list_controller.dart';

class StudentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentListController>(
      () => StudentListController(),
    );
  }
}
