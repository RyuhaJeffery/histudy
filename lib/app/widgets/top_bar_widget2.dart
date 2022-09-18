import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:histudy/app/routes/app_pages.dart';
import 'package:histudy/app/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

Widget topBar2() {
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
                Get.rootDelegate.toNamed(Routes.HOME);
              },
              child: Text(
                "HOME",
                style: TextStyle(color: Color(0xff04589C)),
              )),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.GROUP_INFO);
              },
              child: Text(
                "TEAM",
                style: TextStyle(color: Color(0xff04589C)),
              )),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.QUESTION);
              },
              child: Text(
                "Q&A",
                style: TextStyle(color: Color(0xff04589C)),
              )),
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.ANNOUNCE);
              },
              child: Text(
                "ANNOUNCEMENT",
                style: TextStyle(color: Color(0xff04589C)),
              )),
        ],
      ),
      Row(
        children: [
          TextButton(
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.RANK);
              },
              child: Text(
                "RANK",
                style: TextStyle(color: Color(0xff04589C)),
              )),
          TextButton(
              onPressed: () async {
                await launchUrl(Uri.parse(
                    //"https://fallacious-orchid-f3b.notion.site/Histudy-Guildeline-da4d8c45335b4823b0351928354e1756"
                    "https://half-almanac-c07.notion.site/Histudy-Guildeline-24d0042dd2484ffb989e0aa7e5def3b8"));
              },
              child: Text(
                "GUIDELINE",
                style: TextStyle(color: Color(0xff04589C)),
              )),
          SizedBox(
            width: 110.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff04589C),
                  side: BorderSide(width: 1),
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(5)),
                ),
                onPressed: () {
                  AuthService.to.googleSignOut();
                  Get.rootDelegate.toNamed(Routes.LOGIN);
                },
                child: Text('LOGOUT')),
          )
        ],
      ),
    ]),
  );
}
