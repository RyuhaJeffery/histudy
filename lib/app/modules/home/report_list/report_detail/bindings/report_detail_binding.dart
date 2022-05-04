import 'package:get/get.dart';

import '../controllers/report_detail_controller.dart';

class ReportDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportDetailController>(
      () => ReportDetailController(),
    );
  }
}
