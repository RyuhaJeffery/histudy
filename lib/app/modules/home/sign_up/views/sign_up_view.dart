import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';
import 'package:histudy/app/services/auth_service.dart';

import '../controllers/sign_up_controller.dart';


class SignUpView extends GetView<SignUpController> {
  final nameController = TextEditingController();
  final studentIDController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                  child: Container(
                width: 480,
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
                  width: 350,
                  height: 350,
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'name',
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
                        TextFormField(
                          controller: studentIDController,
                          decoration: InputDecoration(
                            hintText: 'student ID',
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
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            hintText: 'phone number',
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
                        
                        SizedBox(height: 60),
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
                                width: 100,
                                height: 50,
                                child: Center(child: Text("제출"))),
                            onPressed: () async {
                              if(nameController.isBlank == false && studentIDController.isBlank == false && phoneNumberController.isBlank == false){
                                await AuthService.to.firestore.value.collection('Profile')
                                .doc(AuthService.to.auth.value.currentUser!.uid)
                                .set({
                                  'classRegister': false,
                                  'email': AuthService.to.auth.value.currentUser!.email,
                                  'group': 0,
                                  'isAdmin': false,
                                  'myClasses':[],
                                  'name': nameController.text,
                                  'phone': phoneNumberController.text,
                                  'studentNumber': studentIDController.text,
                                  'uid': AuthService.to.auth.value.currentUser!.uid
                                });
                                Get.rootDelegate.toNamed(Routes.HOME);
                              }
                            },
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
                    ),
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
