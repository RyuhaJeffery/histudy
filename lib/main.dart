import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner:false,
      title: "Application",
      initialBinding: BindingsBuilder((){}),
      getPages: AppPages.routes,
    ),
  );
}
