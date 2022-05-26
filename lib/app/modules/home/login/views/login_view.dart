import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/auth_service.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
            ),
            SizedBox(
              height: 281.h,
              width: 367.w,
              child: Image(image: AssetImage('assets/people.png')),
            ),
            SizedBox(
              height: 76.h,
            ),
            ElevatedButton(
              child: Text(
                'SIGN IN WITH GOOGLE',
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(382.h, 56.w)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blue
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.r),
                    )),
              ),
              onPressed: () {
                AuthService.to.signInWithGoogle();
                Get.rootDelegate.toNamed(Routes.HOME);
              },
            ),
          ],
        ),
      ),
    );
  }
}
