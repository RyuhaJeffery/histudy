import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

Widget topBar() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          SizedBox(
              height: 70,
              width: 70,
              child: Image.asset('assets/handong_logo.png')),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              Get.rootDelegate.toNamed(Routes.HOME);
            },
            child: Text(
              'HISTUDY',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.HOME2);
              },
              child: Text("HOME",style: TextStyle(color: Color(0xff04589C)),)),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.GROUP_INFO);
              },
              child: Text("TEAM",style: TextStyle(color: Color(0xff04589C)),)),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.QUESTION);
              },
              child: Text("Q&A",style: TextStyle(color: Color(0xff04589C)),)),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.ANNOUNCE);
              },
              child: Text("ANNOUNCEMENT",style: TextStyle(color: Color(0xff04589C)),)),
        ],
      ),
      Row(
        children: [
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.RANK);
              },
              child: Text("RANK",style: TextStyle(color: Color(0xff04589C)),)),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.GUIDELINE);
              },
              child: Text("GUIDELINE",style: TextStyle(color: Color(0xff04589C)),)),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.MY_PAGE);
              },
              child: Text("MY PAGE",style: TextStyle(color: Color(0xff04589C)),)),

        ],
      ),
    ]),
  );
}