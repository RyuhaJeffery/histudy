import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../../../services/auth_service.dart';
import '../../../widgets/top_bar_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  //  final QuerySnapshot profileResult =

  Rx<bool> classRegister = false.obs;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("Profile")
        .doc(firebaseUser!.uid)
        .get()
        .then(
      (DocumentSnapshot ds) {
        classRegister.value = ds['classRegister'];
      },
    );
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
                              Get.rootDelegate.toNamed(Routes.HOME2);
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
                            onPressed: () {
                              Get.rootDelegate.toNamed(Routes.GUIDELINE);
                            },
                            child: Text(
                              "GUIDELINE",
                              style: TextStyle(color: Color(0xff04589C)),
                            )),
                        SizedBox(
                          width: 88,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff04589C),
                                side: BorderSide(width: 1),
                                shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              onPressed: () {},
                              child: Text('LOGOUT')),
                        )
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 200,
              width: 300,
              child: Image(image: AssetImage('assets/people.png')),
            ),
            SizedBox(
              height: 76,
            ),
            ElevatedButton(
              child: Text(
                'SIGN IN WITH GOOGLE',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
                ),
              ),

              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(350, 56)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
      side: BorderSide(width: 2, color: Colors.black26)
                )),

              ),
              onPressed: () {
                AuthService.to.signInWithGoogle();
              },
            ),
            SizedBox(
              height: 25,
            ),

            classRegister.value
                ? Container(
                    child: Text("You already applied"),
                  )
                : ElevatedButton(
                    child: Text(
                      'REGISTER HISTUDY',
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(350, 56)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black87),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      )),
                    ),
                    onPressed: () {
                      Get.rootDelegate.toNamed(Routes.REGISTER);
                    },
                  ),
            // SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextButton(
            //       onPressed: () {
            //         Get.rootDelegate.toNamed(Routes.GROUP_ADD);
            //       },
            //       child: Text('GROUP ADD'),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Get.rootDelegate.toNamed(Routes.GROUP_DEL);
            //       },
            //       child: Text('GROUP DEL'),
            //     )
            //   ],
            // )
            // ElevatedButton(
            //   child: Text(
            //     'SIGN IN WITH GOOGLE',
            //     style: TextStyle(
            //       fontSize: 25,
            //     ),
            //   ),
            //   style: ButtonStyle(
            //     minimumSize: MaterialStateProperty.all(Size(382, 56)),
            //     backgroundColor: MaterialStateProperty.all<Color>(
            //         Colors.blue
            //     ),
            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(32),
            //         )),
            //   ),
            //   onPressed: () {
            //     AuthService.to.signInWithGoogle();
            //   },
            // ),
            // SizedBox(
            //   height: 25,
            // ),
            // ElevatedButton(
            //   child: Text(
            //     'ADMIN LOGIN',
            //     style: TextStyle(
            //       fontSize: 25,
            //     ),
            //   ),
            //   style: ButtonStyle(
            //     minimumSize: MaterialStateProperty.all(Size(382, 56)),
            //     backgroundColor: MaterialStateProperty.all<Color>(
            //         Colors.black
            //     ),
            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(32),
            //         )),
            //   ),
            //   onPressed: () {
            //     AuthService.to.googleSignOut();
            //   },
            // ),
            // SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextButton(
            //       onPressed: () {
            //         Get.rootDelegate.toNamed(Routes.GROUP_ADD);
            //       },
            //       child: Text('GROUP ADD'),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Get.rootDelegate.toNamed(Routes.GROUP_DEL);
            //       },
            //       child: Text('GROUP DEL'),
            //     )
            //   ],
            // )
          ],
        ),
      );
    }));
  }
}
