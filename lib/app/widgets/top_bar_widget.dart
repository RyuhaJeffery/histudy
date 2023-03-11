import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes/app_pages.dart';

Widget topBar(String? semId, BuildContext context) {
  var reponsiveWidth = MediaQuery.of(context).size.width;
  var reponsiveHeight = MediaQuery.of(context).size.height;
  return reponsiveWidth > 780
      ? Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  histudyLogo(semId, context),
                  SizedBox(
                    width: 8,
                  ),
                  studyTopBar(semId, context),
                ],
              ),
              personalTopBar(semId, context),
            ],
          ),
        )
      : reponsiveWidth > 562
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      histudyLogo(semId, context),
                      SizedBox(
                        width: 8,
                      ),
                      studyTopBar(semId, context),
                    ],
                  ),
                  personalTopBar(semId, context),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  histudyLogo(semId, context),
                  SizedBox(
                    height: 10.h,
                  ),
                  studyTopBar(semId, context),
                  SizedBox(
                    height: 10.h,
                  ),
                  personalTopBar(semId, context),
                ],
              ),
            );
}

Widget histudyLogo(String? semId, BuildContext context) {
  return Row(
    children: [
      SizedBox(
          height: 70, width: 70, child: Image.asset('assets/handong_logo.png')),
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
    ],
  );
}

Widget studyTopBar(String? semId, BuildContext context) {
  return Row(
    children: [
      TextButton(
          onPressed: () {
            if (semId != null) {
              Get.rootDelegate.toNamed(
                Routes.REPORT_LIST,
                arguments: true,
                parameters: {'semId': semId},
              );
            }
          },
          child: Text(
            "REPORT",
            style: TextStyle(color: Color(0xff04589C)),
          )),
      TextButton(
          onPressed: () {
            if (semId != null) {
              Get.rootDelegate.toNamed(
                Routes.GROUP_INFO,
                arguments: true,
                parameters: {'semId': semId},
              );
            }
          },
          child: Text(
            "TEAM",
            style: TextStyle(color: Color(0xff04589C)),
          )),
      TextButton(
          onPressed: () {
            if (semId != null) {
              Get.rootDelegate.toNamed(
                Routes.QUESTION,
                arguments: true,
                parameters: {'semId': semId},
              );
            }
          },
          child: Text(
            "Q&A",
            style: TextStyle(color: Color(0xff04589C)),
          )),
      TextButton(
          onPressed: () {
            if (semId != null) {
              Get.rootDelegate.toNamed(
                Routes.ANNOUNCE,
                arguments: true,
                parameters: {'semId': semId},
              );
            }
          },
          child: Text(
            "ANNOUNCEMENT",
            style: TextStyle(color: Color(0xff04589C)),
          )),
    ],
  );
}

Widget personalTopBar(String? semId, BuildContext context) {
  return Row(
    children: [
      TextButton(
          onPressed: () {
            if (semId != null) {
              Get.rootDelegate.toNamed(
                Routes.RANK,
                arguments: true,
                parameters: {'semId': semId},
              );
            }
          },
          child: Text(
            "RANK",
            style: TextStyle(color: Color(0xff04589C)),
          )),
      TextButton(
          onPressed: () async {
            await launchUrl(Uri.parse(
                "https://fallacious-orchid-f3b.notion.site/Histudy-Guildeline-da4d8c45335b4823b0351928354e1756"));
          },
          child: Text(
            "GUIDELINE",
            style: TextStyle(color: Color(0xff04589C)),
          )),
      TextButton(
          onPressed: () {
            if (semId != null) {
              Get.rootDelegate.toNamed(
                Routes.MY_PAGE,
                arguments: true,
                parameters: {'semId': semId},
              );
            }
          },
          child: Text(
            "MY PAGE",
            style: TextStyle(color: Color(0xff04589C)),
          )),
    ],
  );
}
