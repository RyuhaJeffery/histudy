import 'package:get/get.dart';

import '../controllers/report_write_controller.dart';

class ReportWriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportWriteController>(
      () => ReportWriteController(),
    );
  }
}
