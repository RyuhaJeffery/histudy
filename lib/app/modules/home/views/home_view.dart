import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../../../services/auth_service.dart';
import '../../../widgets/top_bar_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {

    return GetRouterOutlet.builder(builder: ((context, delegate, currentRoute) {

      return Scaffold(
        backgroundColor: Color(0xffFDFFFE),
        body: Column(
          children: [
            topBar(),
            SizedBox(
              height: 281,
              width: 367,
              child: Image(image: AssetImage('assets/people.png')),
            ),
            SizedBox(
              height: 76,
            ),
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
