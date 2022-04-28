import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: ((context, delegate, currentRoute) {
      return Scaffold(
        body: Column(children: [
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.ANNOUNCE);
              },
              child: Text("Announce Page")),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.LOGIN);
              },
              child: Text("Login Page")),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.RANK);
              },
              child: Text("Rank Page"))
        ]),
      );
    }));
  }
}
