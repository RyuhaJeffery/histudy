import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../../../services/auth_service.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  
  @override
  Widget build(BuildContext context) {
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
                            height: 100,
                            width: 100,
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
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.HOME2);
                            },
                            child: Text("HOME")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.GROUP_INFO);
                            },
                            child: Text("TEAM")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.QUESTION);
                            },
                            child: Text("Q&A")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.ANNOUNCE);
                            },
                            child: Text("ANNOUNCEMENT")),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.RANK);
                            },
                            child: Text("RANK")),
                        TextButton(
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.GUIDELINE);
                            },
                            child: Text("GUIDELINE")),
                        ElevatedButton(
                            onPressed: () {
                              AuthService.to.googleSignOut();
                            },
                            child: Text('LOGOUT'))
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
            ElevatedButton(
              child: Text(
                'SIGN IN WITH GOOGLE',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(382, 56)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                )),
              ),
              onPressed: () {
                AuthService.to.signInWithGoogle();
              },
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: Text(
                'ADMIN LOGIN',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(382, 56)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                )),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.rootDelegate.toNamed(Routes.GROUP_ADD);
                  },
                  child: Text('GROUP ADD'),
                ),
                TextButton(
                  onPressed: () {
                    Get.rootDelegate.toNamed(Routes.GROUP_DEL);
                  },
                  child: Text('GROUP DEL'),
                )
              ],
            )
          ],
        ),
      );
    }));
  }
}
