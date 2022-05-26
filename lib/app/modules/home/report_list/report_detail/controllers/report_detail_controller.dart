import 'package:get/get.dart';

import '../../../../../models/report_model.dart';

class ReportDetailController extends GetxController {
  ReportDetailController get to => Get.find();
  //TODO: Implement ReportWriteController
  late ReportModel arg;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
