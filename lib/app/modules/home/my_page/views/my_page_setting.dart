import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:histudy/app/modules/home/my_page/views/my_page_view.dart';
import 'package:histudy/app/widgets/top_bar_widget2.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/my_page_controller.dart';

class MyPageSettingView extends GetView<MyPageController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  User? get userProfile => auth.currentUser;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String name = "";
  String phone = "";
  String studentNumber = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(userProfile!.uid)
        .get()
        .then((DocumentSnapshot ds) {
      name = ds["name"];
      phone = ds["phone"];
      studentNumber = ds["studentNumber"];
      email = ds["email"];
    });

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              topBar2(),
              Center(
                  child: Container(
                width: 600,
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
                  width: 450,
                  height: 650,
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "마이 페이지 수정",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: _nameController.clear,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  // hintText: name,
                                  hintText: "이 름",
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    fontSize: 10,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFECEFF1)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Flexible(
                              child: TextFormField(
                                controller: _studentNumberController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: _studentNumberController.clear,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  //   hintText: studentNumber,
                                  hintText: "학 번",
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(fontSize: 12),
                                  contentPadding: EdgeInsets.only(left: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFECEFF1)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: _emailController.clear,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  // hintText:email,
                                  hintText: "이메일",
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(fontSize: 12),
                                  contentPadding: EdgeInsets.only(left: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFECEFF1)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30),
                            Flexible(
                              child: TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: _phoneController.clear,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  //   hintText: phone,
                                  hintText: "전화 번호 (ex: 010-0000-0000)",
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(fontSize: 12),
                                  contentPadding: EdgeInsets.only(left: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFECEFF1)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
