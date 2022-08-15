import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/edit_my_info_controller.dart';

class EditMyInfoView extends GetView<EditMyInfoController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  User? get userProfile => auth.currentUser;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? name = Get.rootDelegate.parameters['name'];
    String? phone = Get.rootDelegate.parameters['phone'];
    String? studentNumber = Get.rootDelegate.parameters['studentNumber'];
    String? email = Get.rootDelegate.parameters['email'];
    String? semId = Get.rootDelegate.parameters["semId"];

    _nameController.text = name!;
    _phoneController.text = phone!;
    _studentNumberController.text = studentNumber!;
    _emailController.text = email!;

    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: ListView(
        children: [
          Column(
            children: [
              topBar(Get.rootDelegate.parameters['semId']),
              SizedBox(
                height: 22,
              ),
              Text(
                "마이 페이지 수정",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  width: 450,
                  height: 620,
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            // Text("${Get.parameters['name']}"),
                            Flexible(
                              child: TextFormField(
                                //     initialValue: Get.arguments,
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
                        SizedBox(height: 30),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 8,
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    child: Center(
                                        child: Text(
                                      "취 소",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                                onPressed: () {
                                  if (semId != null) {
                                    Get.rootDelegate.toNamed(
                                      Routes.MY_PAGE,
                                      arguments: true,
                                      parameters: {
                                        'semId': semId,
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black26,
                                  //   onPrimary: Colors.black38,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFD1C4E9),
                                    spreadRadius: 8,
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    child: Center(child: Text("제 출"))),
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection('Profile')
                                      .doc(userProfile!.uid)
                                      .update({
                                    'name': _nameController.text,
                                    'studentNumber':
                                        _studentNumberController.text,
                                    'email': _emailController.text,
                                    'phone': _phoneController.text,
                                  });

                                  if (semId != null) {
                                    Get.rootDelegate.toNamed(
                                      Routes.MY_PAGE,
                                      arguments: true,
                                      parameters: {
                                        'semId': semId,
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
