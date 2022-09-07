import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReportListController extends GetxController {
  //TODO: Implement ReportListController

  var groupNum = 0.obs;
  String? semId = Get.rootDelegate.parameters["semId"];

  void setGroupNum(int getNum) {
    groupNum = getNum.obs;
    update();
  }

  getGroupNum() {
    update();
    return groupNum;
  }

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
