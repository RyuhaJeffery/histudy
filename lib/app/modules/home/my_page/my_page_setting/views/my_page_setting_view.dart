import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:histudy/app/modules/home/my_page/my_page_setting/controllers/my_page_setting_controller.dart';
import 'package:histudy/app/modules/home/my_page/views/my_page_view.dart';

import '../../../../../routes/app_pages.dart';


class MyPageSettingView extends GetView<MyPageSettingController> {
  final List<String> subjectItems = ['객체지향 설계 패턴', '소프트웨어 공학', '데이타구조', '운영체제'];
  late final List<String> subjectIs;
  String? subject1;
  String? subject2;
  String? subject3;
  String? subject4;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  User? get userProfile => auth.currentUser;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String name = "";
  String phone = "";
  String studentNumber = "";
  String email = "";
  @override
  Widget build(BuildContext context) {
    print("setting "+"${Get.parameters['name']}");
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: ListView(
        children: [
          Column(
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
                              child: Text("HOME",style: TextStyle(color: Color(0xff04589C)),)),
                          TextButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed(Routes.GROUP_INFO);
                              },
                              child: Text("TEAM",style: TextStyle(color: Color(0xff04589C)),)),
                          TextButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed(Routes.QUESTION);
                              },
                              child: Text("Q&A",style: TextStyle(color: Color(0xff04589C)),)),
                          TextButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed(Routes.ANNOUNCE);
                              },
                              child: Text("ANNOUNCEMENT",style: TextStyle(color: Color(0xff04589C)),)),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed(Routes.RANK);
                              },
                              child: Text("RANK",style: TextStyle(color: Color(0xff04589C)),)),
                          TextButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed(Routes.GUIDELINE);
                              },
                              child: Text("GUIDELINE",style: TextStyle(color: Color(0xff04589C)),)),
                          SizedBox (
                            width: 88,
                            child: ElevatedButton(
                                style:ElevatedButton.styleFrom(primary:  Color(0xff04589C),side: BorderSide(width: 1), shape: RoundedRectangleBorder( //to set border radius to button
                                    borderRadius: BorderRadius.circular(5)
                                ),),
                                onPressed: () {}, child: Text('LOGOUT')),
                          )
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: 22,
              ),
              Text("마이 페이지 수정",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.black87),),

              SizedBox(height: 20,),
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
SizedBox(height: 22,),
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

                                      hintText:"이 름" ,
                                      hintStyle: TextStyle(fontSize: 13,color: Colors.black54),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(fontSize: 10, ),
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
                                      hintStyle: TextStyle(fontSize: 13,color: Colors.black54),
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
                                      hintStyle: TextStyle(fontSize: 13,color: Colors.black54),
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
                                      hintStyle: TextStyle(fontSize: 13,color: Colors.black54),
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
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  //      borderSide: BorderSide(color: Colors.yellowAccent),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFECEFF1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: const Text(
                                '수강중인 과목 1을 선택해주세요.',
                                style: TextStyle(fontSize: 13,color: Colors.black54),
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding:
                              const EdgeInsets.only(left: 15, right: 10),
                              dropdownDecoration: BoxDecoration(
                                //    border: Border.all(width: 1, color:  Color(0xFFECEFF1)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: subjectItems
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                              },
                              onChanged: (value) {
                                subject1 = value.toString();
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                subject1 = value.toString();
                              },
                            ),
                            SizedBox(height: 30),
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.blueGrey[50],
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFECEFF1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFECEFF1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: const Text(
                                '수강중인 과목 2을 선택해주세요.',
                                style: TextStyle(fontSize: 13,color: Colors.black54),
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding:
                              const EdgeInsets.only(left:15, right: 10),
                              dropdownDecoration: BoxDecoration(
                                //      border: Border.all(width: 1, color: Colors.black),
                              ),
                              items: subjectItems
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                              },
                              onChanged: (value) {
                                subject2 = value.toString();
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                subject2 = value.toString();
                              },
                            ),
                            SizedBox(height: 30),
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.blueGrey[50],
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFECEFF1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFECEFF1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: const Text(
                                '수강중인 과목 3을 선택해주세요.',
                                style: TextStyle(fontSize: 13,color: Colors.black54),
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding:
                              const EdgeInsets.only(left: 15, right: 10),
                              dropdownDecoration: BoxDecoration(
                                //      border: Border.all(width: 1, color: Colors.black),
                              ),
                              items: subjectItems
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                              },
                              onChanged: (value) {
                                subject3 = value.toString();
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                subject3 = value.toString();
                              },
                            ),
                            SizedBox(height: 30),
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.blueGrey[50],
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFECEFF1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFFECEFF1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isExpanded: true,
                              hint: const Text(
                                '수강중인 과목 4을 선택해주세요.',
                                style: TextStyle(fontSize: 13,color: Colors.black54),
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding:
                              const EdgeInsets.only(left: 15, right: 10),
                              dropdownDecoration: BoxDecoration(
                                //      border: Border.all(width: 1, color: Colors.black),
                              ),
                              items: subjectItems
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                              },
                              onChanged: (value) {
                                //Do something when changing the item if you want.
                                subject4 = value.toString();
                              },
                              onSaved: (value) {
                                subject4 = value.toString();
                              },
                            ),
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
                                      Get.to(MyPageView());
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
                                      print(subject1);
                                      FirebaseFirestore.instance
                                          .collection('Profile')
                                          .doc(userProfile!.uid)
                                          .update({
                                        'name': _nameController.text,
                                        'studentNumber':
                                        _studentNumberController.text,
                                        'email': _emailController.text,
                                        'phone': _phoneController.text,
                                        'myClasses': FieldValue.arrayUnion([
                                          subject1,
                                          subject2,
                                          subject3,
                                          subject4
                                        ])
                                      });

                                      Get.to(MyPageView());
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
