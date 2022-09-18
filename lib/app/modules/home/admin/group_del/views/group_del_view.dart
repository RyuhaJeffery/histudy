import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../routes/app_pages.dart';
import '../controllers/group_del_controller.dart';

class GroupDelView extends GetView<GroupDelController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Get.rootDelegate.toNamed(Routes.HOME);
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
                          onPressed: () async {
                            await launchUrl(Uri.parse(
                                "https://half-almanac-c07.notion.site/Histudy-Guildeline-24d0042dd2484ffb989e0aa7e5def3b8"));
                          },
                          child: Text("GUIDELINE")),
                      ElevatedButton(onPressed: () {}, child: Text('LOGOUT'))
                    ],
                  ),
                ]),
          ),
          Center(
              child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              width: 320,
              height: 470,
              padding: EdgeInsets.all(30),
              child: _formGroupDel(),
            ),
          )),
        ],
      ),
    );
  }
}

Widget _formGroupDel() {
  return Column(
    children: [
      Text("그룹에서 유저 삭제 "),
      SizedBox(
        height: 10,
      ),
      TextField(
        decoration: InputDecoration(
          hintText: '연도 ex.2020',
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      SizedBox(height: 30),
      TextField(
        decoration: InputDecoration(
          hintText: '학기 ',
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      SizedBox(height: 30),
      TextField(
        decoration: InputDecoration(
          hintText: 'Group 번호 ',
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      SizedBox(height: 30),
      TextField(
        decoration: InputDecoration(
          hintText: '이름 (이메일) ',
          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 30),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFECEFF1)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      SizedBox(height: 40),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD1C4E9),
              spreadRadius: 10,
              blurRadius: 20,
            ),
          ],
        ),
        child: ElevatedButton(
          child: Container(
              width: double.infinity,
              height: 50,
              child: Center(child: Text("제 출"))),
          onPressed: () => print("it's pressed"),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    ],
  );
}
