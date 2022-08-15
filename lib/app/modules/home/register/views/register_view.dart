import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:histudy/app/routes/app_pages.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final classInfo = FirebaseFirestore.instance
      .collection("Class")
      .doc(Get.rootDelegate.parameters['semId'])
      .collection("subClass")
      .orderBy("class");
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
      body: SingleChildScrollView(
        child: Container(
          height: 1000.h,
          child: Column(
            children: [
              topBar(Get.rootDelegate.parameters["semId"]),
              SizedBox(height: 30.h),
              Center(
                child: Container(
                  width: 800,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    width: 450,
                    height: 700,
                    padding: EdgeInsets.all(30),
                    child: StreamBuilder(
                      stream: classInfo.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        length = streamSnapshot.data!.docs.length;
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                              itemCount: length,
                              itemBuilder: (context, index) {
                                _scoreController.add(TextEditingController());

                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                _classCodeList.add(documentSnapshot.id);
                                // _scoreController[index].text = '0';
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        title: Container(
                                          width: 20,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                documentSnapshot['class'],
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "과목코드: ${documentSnapshot['code']} / ${documentSnapshot['professor']} 교수님",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 200,
                                          child: TextFormField(
                                            //     initialValue: Get.arguments,
                                            controller: _scoreController[index],
                                            decoration: InputDecoration(
                                              // hintText: name,

                                              labelText: '가중치 입력',
                                              labelStyle:
                                                  TextStyle(fontSize: 12),
                                              hintText: "0~10",

                                              hintStyle: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black54),
                                              filled: true,
                                              fillColor: Colors.white,

                                              contentPadding:
                                                  EdgeInsets.only(left: 15),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFECEFF1)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter score';
                                              } else if (int.parse(value) < 0) {
                                                return '가중치는 0보다 커야합니다. ';
                                              } else if (int.parse(value) >
                                                  10) {
                                                return '가중치는 10보다 작아야합니다. ';
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.black26,
                                      )
                                    ],
                                  ),
                                );
                              });
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
                    width: 300,
                    height: 35,
                    child: Center(
                      child: Text("제 출"),
                    ),
                  ),
                  onPressed: () async {
                    var classScore = List.generate(0, (index) => 0);

                    for (int i = 0; i < length!; i++) {
                      classScore.add(int.parse(_scoreController[i].text));
                    }

                    // for (int i = 0; i < length!; i++) {
                    //   print(classScore[i]);
                    // }

                    await FirebaseFirestore.instance
                        .collection("Profile")
                        .doc(firebaseUser!.uid)
                        .collection("classScore")
                        .doc(Get.rootDelegate.parameters['semId'])
                        .set({});
                    for (int i = 0; i < length!; i++) {
                      await FirebaseFirestore.instance
                          .collection("Profile")
                          .doc(firebaseUser!.uid)
                          .collection("classScore")
                          .doc(Get.rootDelegate.parameters['semId'])
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
                    String? semId = Get.rootDelegate.parameters['semId'];
                    if (semId != null) {
                      Get.rootDelegate.toNamed(
                        Routes.MY_PAGE,
                        arguments: true,
                        parameters: {'semId': semId},
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
        ),
      ),
    );
  }
}
