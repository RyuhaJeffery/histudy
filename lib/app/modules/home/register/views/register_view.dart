import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final classInfo =
      FirebaseFirestore.instance.collection("Class").orderBy("class");
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // late int classNum;
    // classInfo.snapshots().length.then((value) => classNum = value);

    List<TextEditingController> _scoreController =
        new List.generate(0, (index) => TextEditingController());
    List<String> _classCodeList = new List.generate(0, (index) => "");
    final _formkey = GlobalKey<FormState>();
    int? length;
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Center(
            child: Container(
              width: 600.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
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
                width: 450.w,
                height: 600.h,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                child: StreamBuilder(
                  stream: classInfo.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    length = streamSnapshot.data!.docs.length;
                    if (streamSnapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: length,
                            itemBuilder: (context, index) {
                              _scoreController.add(TextEditingController());

                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              _classCodeList.add(documentSnapshot.id);
                              // _scoreController[index].text = '0';
                              return Card(
                                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                child: ListTile(
                                  leading: Text("${index + 1}"),
                                  title: Column(
                                    children: [
                                      Text(documentSnapshot['class']),
                                      Text(
                                          "과목코드: ${documentSnapshot['code']} / ${documentSnapshot['professor']} 교수님"),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      TextFormField(
                                        controller: _scoreController[index],
                                        decoration: const InputDecoration(
                                            labelText: '가중치 입력',
                                            hintText: "0~10"),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter score';
                                          } else if (int.parse(value) < 0) {
                                            return '가중치는 0보다 커야합니다. ';
                                          } else if (int.parse(value) > 10) {
                                            return '가중치는 10보다 작아야합니다. ';
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            child: Container(
              width: 300.w,
              height: 50.h,
              child: Center(
                child: Text("제 출"),
              ),
            ),
            onPressed: () {
              var classScore = List.generate(0, (index) => 0);

              for (int i = 0; i < length!; i++) {
                classScore.add(int.parse(_scoreController[i].text));
              }

              // for (int i = 0; i < length!; i++) {
              //   print(classScore[i]);
              // }
              print(firebaseUser!.uid);

              for (int i = 0; i < length!; i++) {
                FirebaseFirestore.instance
                    .collection("Profile")
                    .doc(firebaseUser!.uid)
                    .collection("classScore")
                    .doc("classScore")
                    .update({
                  _classCodeList[i].toString(): classScore[i],
                });
              }
              FirebaseFirestore.instance
                  .collection("Profile")
                  .doc(firebaseUser!.uid)
                  .update({
                "classRegister": true,
              });
              Get.rootDelegate.toNamed(Routes.HOME);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
