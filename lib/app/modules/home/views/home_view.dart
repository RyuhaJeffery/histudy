import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:histudy/app/repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../../../services/auth_service.dart';
import '../../../widgets/top_bar_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // FirebaseAuth auth = FirebaseAuth.instance;
  // User? currentUser;
  // var firebaseUser = FirebaseAuth.instance.currentUser;

  // User? get userProfile => auth.currentUser;
  late String semId;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("year")
        .where("thisSem", isEqualTo: true)
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((doc) {
        semId = doc.id;
      });
    });

    bool test = true;
    return GetRouterOutlet.builder(builder: ((context, delegate, currentRoute) {
      return Scaffold(
        backgroundColor: Color(0xffFDFFFE),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(
                                Routes.REPORT_LIST,
                                arguments: true,
                                parameters: {'semId': semId},
                              );
                            },
                            child: Text(
                              "REPORT",
                              style: TextStyle(color: Color(0xff04589C)),
                            )),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(
                                Routes.GROUP_INFO,
                                arguments: true,
                                parameters: {'semId': semId},
                              );
                            },
                            child: Text(
                              "TEAM",
                              style: TextStyle(color: Color(0xff04589C)),
                            )),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(
                                Routes.QUESTION,
                                arguments: true,
                                parameters: {'semId': semId},
                              );
                            },
                            child: Text(
                              "Q&A",
                              style: TextStyle(color: Color(0xff04589C)),
                            )),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(
                                Routes.ANNOUNCE,
                                arguments: true,
                                parameters: {'semId': semId},
                              );
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
                              Get.rootDelegate.toNamed(
                                Routes.RANK,
                                arguments: true,
                                parameters: {'semId': semId},
                              );
                            },
                            child: Text(
                              "RANK",
                              style: TextStyle(color: Color(0xff04589C)),
                            )),
                        TextButton(
                            onPressed: () async {
                              await launchUrl(Uri.parse(
                                  "https://fish-gooseberry-dad.notion.site/Histudy-Guideline-866b2e628da247bcac615924fd718667"));
                            },
                            child: Text(
                              "GUIDELINE",
                              style: TextStyle(color: Color(0xff04589C)),
                            )),
                        FirebaseAuth.instance.currentUser != null
                            ? TextButton(
                                onPressed: () {
                                  Get.rootDelegate.toNamed(
                                    Routes.MY_PAGE,
                                    arguments: true,
                                    parameters: {'semId': semId},
                                  );
                                },
                                child: Text(
                                  "MY PAGE",
                                  style: TextStyle(color: Color(0xff04589C)),
                                ))
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff04589C),
                                  side: BorderSide(width: 1),
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () {
                                  Get.rootDelegate.toNamed(Routes.LOGIN);
                                },
                                child: Text('LOGIN'))
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 281,
              width: 367,
              child: Image(image: AssetImage('assets/people.png')),
            ),
            SizedBox(
              height: 76,
            ),
            IconButton(
              icon: Icon(
                Icons.egg,
                size: 15,
                color: Color.fromARGB(255, 41, 41, 246).withOpacity(0.1),
              ),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text("22-1 Software Engineering 5조입니다."),
                    content: Column(
                      children: [
                        SizedBox(
                          height: 400.h,
                          width: 600.w,
                          child: Image(
                            image: AssetImage('assets/seGroup.JPG'),
                          ),
                        ),
                        Text(
                            "안녕하세요. Histudy를 개발한 류운선, 김선욱, 이강민, 정예찬, 배수빈, 이산하입니다."),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }));
  }
}
