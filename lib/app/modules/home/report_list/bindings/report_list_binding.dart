import 'package:get/get.dart';

import '../controllers/report_list_controller.dart';

class ReportListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportListController>(
      () => ReportListController(),
    );
  }
}
