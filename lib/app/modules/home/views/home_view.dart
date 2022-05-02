import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../../../services/auth_service.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: ((context, delegate, currentRoute) {
      return Scaffold(
        body: Column(
          children: [
            // Row(children: [
            //   TextButton(
            //       onPressed: () {
            //         Get.rootDelegate.toNamed(Routes.ANNOUNCE);
            //       },
            //       child: Text("Announce Page")),
            //   TextButton(
            //       onPressed: () {
            //         Get.rootDelegate.toNamed(Routes.LOGIN);
            //       },
            //       child: Text("Login Page")),
            //   TextButton(
            //       onPressed: () {
            //         Get.rootDelegate.toNamed(Routes.RANK);
            //       },
            //       child: Text("Rank Page"))
            // ]),
            Container(
              height: 100,
              color: Colors.blue,
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
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                )),
              ),
              onPressed: () {
                AuthService.to.handleSignIn();
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
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.black
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    )),
              ),
              onPressed: () {
                Get.rootDelegate.toNamed(Routes.REPORT_DETAILE);
              },
            ),
          ],
        ),
      );
    }));
  }
}
