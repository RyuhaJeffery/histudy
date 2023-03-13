import 'dart:convert';
import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';

import 'package:get/get.dart';
import 'package:histudy/app/services/auth_service.dart';
import 'package:histudy/app/widgets/top_bar_widget2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/classScore_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/top_bar_widget.dart';
import '../controllers/my_page_controller.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class MyPageView extends GetView<MyPageController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  User? get userProfile => auth.currentUser;

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection('Profile')
        .doc(userProfile!.uid)
        .snapshots();
    //  print(userProfile!.uid);

    String? semId = Get.rootDelegate.parameters["semId"];

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              topBar(Get.rootDelegate.parameters["semId"], context),
              Text(
                "마이 페이지",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 22,
              ),
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
                  height: 700,
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return IconButton(
                                    onPressed: () {
                                      if (semId != null) {
                                        Get.rootDelegate.toNamed(
                                          Routes.EDIT_MY_INFO,
                                          arguments: true,
                                          parameters: {
                                            'semId': semId,
                                            "name": getdata!["name"],
                                            "studentNumber":
                                                getdata["studentNumber"],
                                            "email": getdata["email"],
                                            "phone": getdata["phone"]
                                          },
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      PhosphorIcons.pencil, // Pencil Icon
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "이름",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 250,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["name"]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(width: 30),
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "학번",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 250,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["studentNumber"]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "이메일",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 250,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["email"]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(width: 30),
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "전화 번호",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 250,
                                        //margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEFF1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${getdata?["phone"]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 60),
                        StreamBuilder<DocumentSnapshot>(
                          stream: _userStream,
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            final getdata = snapshot.data;
                            if (snapshot.hasData) {
                              return getdata?['isAdmin']
                                  ? Column(
                                      children: [
                                        ElevatedButton(
                                          child: Text(
                                            'Create Group',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black54),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () async {
                                            createGroup();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            'Edit Year & Semester',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black54),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () {
                                            if (semId != null) {
                                              Get.rootDelegate.toNamed(
                                                Routes.EDIT_SEM,
                                                arguments: true,
                                                parameters: {'semId': semId},
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            'Edit Class',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black45),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () {
                                            if (semId != null) {
                                              Get.rootDelegate.toNamed(
                                                Routes.EDIT_CLASS,
                                                arguments: true,
                                                parameters: {'semId': semId},
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            'CSV with study group',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black54),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () {
                                            if (semId != null) {
                                              Get.rootDelegate.toNamed(
                                                Routes.GROUP_CREATE,
                                                arguments: true,
                                                parameters: {'semId': semId},
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            'Export Study Group Result',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black26),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () async {
                                            String sem = "";
                                            await FirebaseFirestore.instance
                                                .collection("year")
                                                .doc(semId)
                                                .get()
                                                .then((value) {
                                              sem += value["year"].toString() +
                                                  "_" +
                                                  value["semester"].toString();
                                              exportResult(sem);
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            'Adjust (remove duplicated) Result',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black26),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () async {
                                            removeDuplicatedResult();
                                          },
                                        ),

                                        // SizedBox(
                                        //   height: 20.h,
                                        // ),
                                        // ElevatedButton(
                                        //   child: Text(
                                        //     '2022-2 부족한 데이터 추가 버튼',
                                        //     style: TextStyle(
                                        //       fontSize: 18,
                                        //     ),
                                        //   ),
                                        //   style: ButtonStyle(
                                        //     minimumSize:
                                        //         MaterialStateProperty.all(
                                        //             Size(280, 40)),
                                        //     backgroundColor:
                                        //         MaterialStateProperty
                                        //             .all<Color>(Color.fromARGB(
                                        //                 208, 255, 0, 0)),
                                        //     shape: MaterialStateProperty.all<
                                        //             RoundedRectangleBorder>(
                                        //         RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(27),
                                        //     )),
                                        //   ),
                                        //   onPressed: () {
                                        //     Get.dialog(
                                        //       AlertDialog(
                                        //         title: Text(
                                        //             "데이터 베이스에 많은 트래픽이 생깁니다."),
                                        //         content: Text("처음 한번만 시도하십시오"),
                                        //         actions: [
                                        //           TextButton(
                                        //               onPressed: () async {
                                        //                 final CollectionReference
                                        //                     _profile =
                                        //                     FirebaseFirestore
                                        //                         .instance
                                        //                         .collection(
                                        //                             'Profile');
                                        //                 List<
                                        //                         Map<String,
                                        //                             dynamic>>
                                        //                     classInfo =
                                        //                     List.empty(
                                        //                         growable: true);
                                        //                 FirebaseFirestore
                                        //                     .instance
                                        //                     .collection("Class")
                                        //                     .doc(semId)
                                        //                     .collection(
                                        //                         'subClass')
                                        //                     .get()
                                        //                     .then((QuerySnapshot
                                        //                         qs) {
                                        //                   qs.docs.forEach(
                                        //                       (element) {
                                        //                     var mapTemp = {
                                        //                       "id": element.id,
                                        //                       "class": element[
                                        //                           "class"],
                                        //                       "professor":
                                        //                           element[
                                        //                               "professor"]
                                        //                     };
                                        //                     classInfo
                                        //                         .add(mapTemp);
                                        //                   });
                                        //                 });

                                        //                 _profile.get().then(
                                        //                     (QuerySnapshot
                                        //                         qs1) {
                                        //                   qs1.docs.forEach(
                                        //                       (documentSnapshot) {
                                        //                     if (documentSnapshot[
                                        //                             'classRegister'] ==
                                        //                         true) {
                                        //                       String
                                        //                           registeredClass =
                                        //                           "true";
                                        //                       _profile
                                        //                           .doc(
                                        //                               documentSnapshot
                                        //                                   .id)
                                        //                           .collection(
                                        //                               'classScore')
                                        //                           .doc(semId)
                                        //                           .get()
                                        //                           .then((DocumentSnapshot
                                        //                               classDs) {
                                        //                         for (int j = 10;
                                        //                             j > 0;
                                        //                             j--) {
                                        //                           for (int i =
                                        //                                   0;
                                        //                               i <
                                        //                                   classInfo
                                        //                                       .length;
                                        //                               i++) {
                                        //                             if (classDs[classInfo[i]
                                        //                                     [
                                        //                                     "id"]] ==
                                        //                                 j) {
                                        //                               registeredClass += "/" +
                                        //                                   classInfo[i]["class"]
                                        //                                       .toString() +
                                        //                                   "(" +
                                        //                                   classInfo[i]["professor"]
                                        //                                       .toString() +
                                        //                                   ")[" +
                                        //                                   classDs[classInfo[i]["id"]]
                                        //                                       .toString() +
                                        //                                   "]";
                                        //                             }
                                        //                           }
                                        //                         }

                                        //                         //여기서 각자 유저마다 올리는 작업이 필요함.
                                        //                         _profile
                                        //                             .doc(
                                        //                                 documentSnapshot
                                        //                                     .id)
                                        //                             .update({
                                        //                           "registeredClass":
                                        //                               registeredClass,
                                        //                         });
                                        //                       });
                                        //                     } else {
                                        //                       _profile
                                        //                           .doc(
                                        //                               documentSnapshot
                                        //                                   .id)
                                        //                           .update({
                                        //                         "registeredClass":
                                        //                             "",
                                        //                       });
                                        //                     }
                                        //                   });
                                        //                 });
                                        //                 Get.back();
                                        //               },
                                        //               child: Text("예"))
                                        //         ],
                                        //       ),
                                        //     );
                                        //   },
                                        // )
                                      ],
                                    )
                                  : getdata?['classRegister']
                                      ? getdata!['group'] != 0
                                          ? Container()
                                          : Column(
                                              children: [
                                                Container(
                                                  child: Text("이미 신청하셨습니다."),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                ElevatedButton(
                                                  child: Text(
                                                    '매칭 신청한 교과목 확인하기',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size(280, 40)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.black54),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              27),
                                                    )),
                                                  ),
                                                  onPressed: () async {
                                                    if (semId != null) {
                                                      Get.rootDelegate.toNamed(
                                                        Routes.REGISTERED,
                                                        arguments: true,
                                                        parameters: {
                                                          'semId': semId
                                                        },
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            )
                                      : ElevatedButton(
                                          child: Text(
                                            '이번학기 Histudy를 신청하세요!',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black54),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () async {
                                            late int classlength;

                                            await FirebaseFirestore.instance
                                                .collection("Class")
                                                .doc(Get.rootDelegate
                                                    .parameters['semId'])
                                                .collection("subClass")
                                                .get()
                                                .then((QuerySnapshot qs) {
                                              // List<ClassScore>.generate(qs.docs.length, (index) {});
                                              classlength = qs.docs.length;
                                            });
                                            if (semId != null) {
                                              Get.rootDelegate.toNamed(
                                                Routes.REGISTER,
                                                arguments: true,
                                                parameters: {
                                                  'semId': semId,
                                                  'classlength':
                                                      classlength.toString(),
                                                },
                                              );
                                            }
                                          },
                                        );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 7, 113, 200),
                            side: BorderSide(width: 1),
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: Text("로그아웃 하시겠습니까?"),
                                // content: Text(""),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      AuthService.to.googleSignOut();
                                      Get.snackbar(
                                        "로그아웃 완료",
                                        "다시 로그인 하세요",
                                        backgroundColor: Color(0xff04589C),
                                        colorText: Color(0xffF0F0F0),
                                      );
                                      Get.rootDelegate.toNamed(Routes.HOME);
                                    },
                                    child: Text("예"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("아니요"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("로그아웃"),
                        )
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

Future registeredClass() async {
  return Get.dialog(
    AlertDialog(
      title: Text("Firebase에 수업 정보가 업로드 됩니다"),
      content: Text("기존에 올라가 있는 수업 정보는 지워집니다."),
      actions: [
        TextButton(
          onPressed: () {
            Get.snackbar(
              "수업 업로드 완료",
              "DB에서 정보를 확인하세요",
              backgroundColor: Color(0xff04589C),
              colorText: Color(0xffF0F0F0),
            );
          },
          child: Text("다시 신청하기"),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("아니요"),
        ),
      ],
    ),
  );
}

void removeDuplicatedResult() async {
  Get.snackbar("스터디 결과 정리중", "중복되어 있는 결과를 삭제중입니다. 1분 후 csv 파일을 출력하세요");
  String? semId = Get.rootDelegate.parameters['semId'];
  String sem = "";
  await FirebaseFirestore.instance
      .collection("year")
      .doc(semId)
      .get()
      .then((value) {
    sem += value["year"].toString() + "_" + value["semester"].toString();
  });

  //개인 데이터 정리
  await FirebaseFirestore.instance
      .collection(semId!)
      .doc(semId)
      .collection('Group')
      .get()
      .then((QuerySnapshot querySnapshot) async {
    querySnapshot.docs.forEach((doc) {
      List<dynamic> members;
      members = doc["members"];
      for (int i = 0; i < members.toSet().toList().length; i++) {
        FirebaseFirestore.instance
            .collection("Profile")
            .doc(members[i])
            .update({
          "${semId}_time": 0,
          "${semId}_meeting": 0,
        });
        Future.delayed(Duration(seconds: 1));
      }
    });
  });

  //개인 데이터 업데이트
  await FirebaseFirestore.instance
      .collection(semId)
      .doc(semId)
      .collection('Group')
      .get()
      .then((QuerySnapshot querySnapshot) {
    int lastGroup = querySnapshot.docs.length;
    int check = 0;
    querySnapshot.docs.forEach((doc) {
      FirebaseFirestore.instance
          .collection(semId)
          .doc(semId)
          .collection('Group')
          .doc(doc.id)
          .collection("reports")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((subDoc) {
          List<dynamic> participants;
          int duration;
          participants = subDoc['participants'].toSet().toList();
          duration = subDoc['duration'];

          for (int i = 0; i < participants.toSet().toList().length; i++) {
            FirebaseFirestore.instance
                .collection("Profile")
                .doc(participants[i])
                .update({
              "${semId}_time": FieldValue.increment(duration),
              "${semId}_meeting": FieldValue.increment(1)
            }).then((value) {
              if (int.parse(doc.id) > (lastGroup - 8) && check == 0) {
                check = 1;
                Get.dialog(
                  AlertDialog(
                    title: Text("중복 데이터 정리 완료 되었습니다."),
                    content: Text("csv 파일 출력을 할 수 있습니다. "),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Future.delayed(Duration(milliseconds: 1500));
                          Get.back();
                          exportResult(sem);
                        },
                        child: Text("csv 파일 출력"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Get.back();
                        },
                        child: Text("닫기"),
                      ),
                    ],
                  ),
                );
              }
            });
            Future.delayed(Duration(milliseconds: 10));
          }
          FirebaseFirestore.instance
              .collection(semId)
              .doc(semId)
              .collection('Group')
              .doc(doc.id)
              .collection("reports")
              .doc(subDoc.id)
              .update({"participants": participants});
        });
      });
    });
  });
}

void exportResultReal(List<List<dynamic>> exportData, String sem) async {
  String? semId = Get.rootDelegate.parameters['semId'];
//now convert our 2d array into the csvlist using the plugin of csv
  String csv = ListToCsvConverter().convert(exportData);
//this csv variable holds entire csv data
//Now Convert or encode this csv string into utf8
  final bytes = utf8.encode(csv);
//NOTE THAT HERE WE USED HTML PACKAGE
  final blob = html.Blob([bytes]);
//It will create downloadable object
  final url = html.Url.createObjectUrlFromBlob(blob);
//It will create anchor to download the file
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = "${sem}_study_result.csv";
//finally add the csv anchor to body
  html.document.body!.children.add(anchor);
// Cause download by calling this function
  anchor.click();
//revoke the object
  html.Url.revokeObjectUrl(url);
  Get.rootDelegate.toNamed(
    Routes.MY_PAGE,
    arguments: true,
    parameters: {'semId': semId!},
  );
}

void exportResult(String sem) async {
  String? semId = Get.rootDelegate.parameters['semId'];
  final CollectionReference _profile =
      FirebaseFirestore.instance.collection('Profile');
  await Get.snackbar("스터디 결과 생성중", "결과 생성중입니다. 생성 후 안내창이 나타납니다.");
  List<String> exportHeader = [
    "name",
    "studentNumber",
    "group",
    "groupStudyNum",
    "personalStudyNum",
    "personalStudyTime",
  ];
  List<List<dynamic>> exportData = [];

  exportData.add(exportHeader);
  await _profile.get().then((QuerySnapshot qs1) {
    qs1.docs.forEach((documentSnapshot) async {
      // if (documentSnapshot["classRegister"] == true) {
      List<dynamic> exportRow = [];

      if (documentSnapshot["group"] != 0) {
        FirebaseFirestore.instance
            .collection(semId!)
            .doc(semId)
            .collection("Group")
            .doc(documentSnapshot["group"].toString())
            .get()
            .then((subDs) {
          exportRow.add(documentSnapshot["name"]);
          exportRow.add(documentSnapshot["studentNumber"]);
          exportRow.add(documentSnapshot["group"]);
          exportRow.add(subDs["meeting"]);

          exportRow.add(
              documentSnapshot.data().toString().contains("${semId}_meeting")
                  ? documentSnapshot["${semId}_meeting"]
                  : 0);
          documentSnapshot.data().toString().contains("${semId}_time")
              ? exportRow.add(documentSnapshot["${semId}_time"])
              : exportRow.add(0);

          exportData.add(exportRow);
        });
      } else {
        exportRow.add(documentSnapshot["name"]);
        exportRow.add(documentSnapshot["studentNumber"]);
        exportRow.add(documentSnapshot["group"]);
        exportRow.add(0);

        exportRow.add(
            documentSnapshot.data().toString().contains("${semId}_meeting")
                ? documentSnapshot["${semId}_meeting"]
                : 0);
        documentSnapshot.data().toString().contains("${semId}_time")
            ? exportRow.add(documentSnapshot["${semId}_time"])
            : exportRow.add(0);

        exportData.add(exportRow);
      }
      // }
    });
  });

  await Get.dialog(
    AlertDialog(
      title: Text("study 결과를 export 하시겠습니까?"),
      content: Text("예를 누르면 결과가 다운로드 됩니다."),
      actions: [
        TextButton(
          onPressed: () async {
            exportResultReal(exportData, sem);
          },
          child: Text("예"),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
          },
          child: Text("닫기"),
        ),
      ],
    ),
  );
}

void addMissingData() async {
  String? semId = Get.rootDelegate.parameters['semId'];
  List<String> profileList = new List.generate(0, (index) => "");
  final QuerySnapshot profileResult = await FirebaseFirestore.instance
      .collection('Profile')
      .where("classRegister", isEqualTo: true)
      .get();
  final profileLen = profileResult.docs.length;
  final List<DocumentSnapshot> profileDocs = profileResult.docs;
  profileDocs.forEach((profile) {
    profileList.add(profile.id);
  });

  List<String> classList = new List.generate(0, (index) => "");
  final QuerySnapshot classResult = await FirebaseFirestore.instance
      .collection('Class')
      .doc(semId)
      .collection("subClass")
      .get();
  final classLen = classResult.docs.length;
  final List<DocumentSnapshot> classDocs = classResult.docs;
  classDocs.forEach((classele) {
    classList.add(classele.id);
  });
}

//해당기능은 csv 파일 뽑는 것으로 수정해야함.
void createGroup() async {
  String? semId = Get.rootDelegate.parameters['semId'];
  int? year;
  int? semester;

  await FirebaseFirestore.instance
      .collection("year")
      .doc(semId)
      .get()
      .then((DocumentSnapshot ds) {
    year = ds['year'];
    semester = ds['semester'];
  });
  await Future.delayed(Duration(seconds: 1));

  if (semId != null) {
    Get.snackbar(
      "그룹 배정 시작",
      " 끝나면 스낵바로 알람이 갑니다. ",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
    List<String> profileList = new List.generate(0, (index) => "");
    //학생수 만큼 불러오기
    final QuerySnapshot profileResult = await FirebaseFirestore.instance
        .collection('Profile')
        .where("classRegister", isEqualTo: true)
        .get();
    final profileLen = profileResult.docs.length;
    final List<DocumentSnapshot> profileDocs = profileResult.docs;
    profileDocs.forEach((profile) {
      profileList.add(profile.id);
    });
    await Future.delayed(Duration(seconds: 4));
    print(profileList);
    print("profile");

    Get.snackbar(
      "학생들 목록 불러오기 성공!",
      "$profileList ${profileList.length}명의 학생",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );

    //서로 연결을 원하는 친구는 맺어질 수 있도록 한다.
    //등록시에 profile subcollection에 friend 항목을 넣고 매칭 원하는 user의 uid를 넣는다.

    //class id list
    //class 수만큼 불러오기
    List<String> classList = new List.generate(0, (index) => "");
    final QuerySnapshot classResult = await FirebaseFirestore.instance
        .collection('Class')
        .doc(semId)
        .collection("subClass")
        .get();
    final classLen = classResult.docs.length;
    final List<DocumentSnapshot> classDocs = classResult.docs;
    classDocs.forEach((classele) {
      classList.add(classele.id);
    });
    await Future.delayed(Duration(seconds: 4));

    print(classList);
    print("classList");
    Get.snackbar(
      "수업 목록 불러오기 성공!",
      "$classList ${classList.length}개의 수업이 있음. ",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );

    //각각 학생들 마다 classScore의 점수를 가져와야함.
    //학생 x 숫자 배열 생성하기
    var studentScore =
        List.generate(profileLen, (i) => new List.filled(classLen, 0));
    //값 가져오기
    for (int i = 0; i < profileLen; i++) {
      await FirebaseFirestore.instance
          .collection("Profile")
          .doc(profileList[i])
          .collection("classScore")
          .doc(semId)
          .get()
          .then(
        (DocumentSnapshot ds) {
          Map<String, dynamic> scoreData = ds.data()! as Map<String, dynamic>;
          for (int j = 0; j < classLen; j++) {
            studentScore[i][j] = scoreData[classList[j]] ?? 0;
          }
        },
      );
    }

    //load되는 시간 기다리기
    // await Future.delayed(Duration(seconds: 3));

    // for (int i = 0; i < profileLen; i++) {
    //   await FirebaseFirestore.instance
    //       .collection("Profile")
    //       .doc(profileList[i])
    //       .collection(semId)
    //       .get()
    //       .then(
    //     (QuerySnapshot qs) {
    //       // for (int j = 0; j < classLen; j++) {
    //       //   studentScore[i][j] = ds[classList[j]];
    //       // }
    //     },
    //   );
    // }

    print("studentScore");
    Get.snackbar(
      "점수 x 학생 수의 갯수는 아래와 같습니다.",
      "${classList.length * profileList.length}개의 읽기가 필요함.",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
    await Future.delayed(Duration(seconds: 3));

    //학생들간의 관계도 그리기
    var graph = List.generate(
        profileLen, (i) => new List.filled(profileLen, 0, growable: false));

    int maxscore = 2147483640;
    Get.snackbar(
      "학생들간 점수 조합 시작",
      "계속해서 진행상황 알림이 갑니다.",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );

    for (int i = 0; i < profileLen; i++) {
      for (int j = i + 1; j < profileLen; j++) {
        int allTemp = 0;

        for (int k = 0; k < classLen; k++) {
          allTemp += await studentScore[i][k] * studentScore[j][k];
        }

        //만약 여기서 서로 등록을 했다면 가중치를 최대로 올려야 함.
        //여기서 조회 해야함.
        //양쪽다 있어야 할 때 코드
        // await FirebaseFirestore.instance
        //     .collection("Profile")
        //     .doc(profileList[i])
        //     .collection(semId)
        //     .doc(profileList[j])
        //     .get()
        //     .then(
        //   (DocumentSnapshot ds1) {
        //     if (ds1.exists) {
        //       //상대편것도 확인 해야함.
        //       FirebaseFirestore.instance
        //           .collection("Profile")
        //           .doc(profileList[j])
        //           .collection(semId)
        //           .doc(profileList[i])
        //           .get()
        //           .then(
        //         (DocumentSnapshot ds) {
        //           if (ds.exists) {
        //             allTemp = maxscore;
        //           }
        //         },
        //       );
        //     }
        //   },
        // );

        //한쪽만 있어도 되는 코드
        await FirebaseFirestore.instance
            .collection("Profile")
            .doc(profileList[i])
            .collection(semId)
            .doc(profileList[j])
            .get()
            .then(
          (DocumentSnapshot ds1) {
            if (ds1.exists) {
              allTemp = maxscore;
            }
          },
        );

        await FirebaseFirestore.instance
            .collection("Profile")
            .doc(profileList[j])
            .collection(semId)
            .doc(profileList[i])
            .get()
            .then(
          (DocumentSnapshot ds2) {
            if (ds2.exists) {
              allTemp = maxscore;
            }
          },
        );
        graph[i][j] = allTemp;
      }
      Get.snackbar(
        "현재 ${i + 1}번째 학생과 ${profileList.length - i - 1}개의 조합 성공",
        "${profileList.length - i}개 남음",
        backgroundColor: Color(0xff04589C),
        colorText: Color(0xffF0F0F0),
      );
    }

    print(graph);

    //group 계산해서 넣어둠.
    //미리 매칭된 그룹은 빠지지 않도록 해야함.

    int allCount = profileLen;
    //현재는 4개에 맞추어져 있음.
    int groupMember = 4;
    //여기 필수로 수정해줘야함.
    int groupNumber = -1;

    await Get.snackbar(
      "학생들과 점수 관계도 생성 완료",
      "그룹 조합 매칭 시작합니다.",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
    //4개씩 끊어서 올리기

    List<String> exportHeader = [
      "id",
      "group",
      "name",
      "email",
      "friend",
      "classScore"
    ];
    List<List<dynamic>> exportData = [];
    exportData.add(exportHeader);
    final CollectionReference _profile =
        FirebaseFirestore.instance.collection('Profile');
    Map<String, String> registeredFriend = {};
    await _profile.get().then((QuerySnapshot qs1) {
      qs1.docs.forEach((documentSnapshot) async {
        if (documentSnapshot['classRegister'] == true) {
          //같이하기로한 친구 불러오기
          String tempData = "";
          _profile
              .doc(documentSnapshot.id)
              .collection(semId)
              .get()
              .then((QuerySnapshot qs) {
            qs.docs.forEach((doc) {
              tempData +=
                  doc["name"] + "/" + doc["studentNumber"] + "/" + doc.id + "/";
            });

            Map<String, String> tempMap = {documentSnapshot.id: tempData};
            registeredFriend.addAll(tempMap);
          });
        }
      });
    });

    await Get.snackbar(
      "csv file export 준비 완료",
      "그룹 조합 매칭 시작합니다.",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
    int k = 1;
    while (allCount > groupMember) {
      //가장 큰 값을 가지고 있는 노드 확인
      //최대값 찾기
      //maxNode는 작은 순으로 해서 함.

      var max = List.generate(groupMember - 1, (i) => -1);
      var maxNode = List.generate(groupMember, (i) => -1);
      print(k++);
      for (int i = 0; i < profileLen; i++) {
        for (int j = i + 1; j < profileLen; j++) {
          if (graph[i][j] > max[0]) {
            max[0] = graph[i][j];
            maxNode[0] = i;
            maxNode[1] = j;
          }
        }
      }
      //두개의 노드가 설정 되었으면
      //그 두개의 node에서 max인거 또 찾음.

      for (int i = 0; i < profileLen; i++) {
        if (i != maxNode[0] && i != maxNode[1]) {
          if (graph[maxNode[0]][i] > max[1]) {
            maxNode[2] = i;
            max[1] = graph[maxNode[0]][i];
          } else if (graph[maxNode[1]][i] > max[1]) {
            maxNode[2] = i;
            max[1] = graph[maxNode[0]][i];
          }
        }
      }

      for (int i = 0; i < profileLen; i++) {
        if (i != maxNode[0] && i != maxNode[1] && i != maxNode[2]) {
          if (graph[maxNode[0]][i] > max[2]) {
            maxNode[3] = i;
            max[2] = graph[maxNode[0]][i];
          } else if (graph[maxNode[1]][i] > max[2]) {
            maxNode[3] = i;
            max[2] = graph[maxNode[0]][i];
          } else if (graph[maxNode[2]][i] > max[2]) {
            maxNode[3] = i;
            max[2] = graph[maxNode[0]][i];
          }
        }
      }

      //선택된 node에 연결된 edge들은 -1로
      for (int i = 0; i < groupMember; i++) {
        for (int j = 0; j < profileLen; j++) {
          graph[maxNode[i]][j] = -1000;
        }

        await _profile.get().then((QuerySnapshot qs1) {
          qs1.docs.forEach((documentSnapshot) async {
            if (documentSnapshot.id == profileList[maxNode[i]]) {
              List<dynamic> exportRow = [];
              exportRow.add(documentSnapshot.id);
              exportRow.add(groupNumber * (-1));
              exportRow.add(documentSnapshot["name"]);
              exportRow.add(documentSnapshot["email"]);
              exportRow.add(registeredFriend[documentSnapshot.id]);
              exportRow.add(documentSnapshot["registeredClass"]);
              exportData.add(exportRow);
            }
          });
        });

        //firebase에 업로드 하기
        //maxNode에 잡힌 uid 불러와서 update하기
        // await FirebaseFirestore.instance
        //     .collection("Profile")
        //     .doc(profileList[maxNode[i]])
        //     .update({
        //   "group": groupNumber * (-1),
        // });

        //group list에도 넣어야 .
        // await FirebaseFirestore.instance
        //     .collection(semId)
        //     .doc(semId)
        //     .collection("Group")
        //     .doc((-1 * groupNumber).toString())
        //     .set({
        //   'meeting': 0,
        //   'imageUrl': "",
        //   'members': [
        //     profileList[maxNode[0]],
        //     profileList[maxNode[1]],
        //     profileList[maxNode[2]],
        //     profileList[maxNode[3]],
        //   ],
        //   'no': 0,
        //   'sem': semester,
        //   'time': 0,
        //   'year': year,
        // });
      }

      Get.snackbar(
        "${groupNumber - 1}번째 그룹 생성 완료",
        "",
        backgroundColor: Color(0xff04589C),
        colorText: Color(0xffF0F0F0),
      );

      await Future.delayed(Duration(seconds: 1));
      max.clear();
      maxNode.clear();
      groupNumber--;
      allCount -= 4;
    }

    //남은 학생들 그룹에 넣기

    int temp = 0;
    var left = List.generate(allCount, (i) => -1, growable: true);

    for (int i = 0; i < profileLen; i++) {
      if (graph[i][0] >= 0) {
        for (int j = 0; j < profileLen; j++) {
          graph[i][j] = groupNumber;
        }
        await FirebaseFirestore.instance
            .collection("Profile")
            .doc(profileList[i])
            .update({
          "group": groupNumber * (-1),
        });
        left[temp] = i;
        temp++;
      }
    }

    var leftProfile = List.generate(temp, (index) => "", growable: true);

    for (int i = 0; i < temp; i++) {
      leftProfile[i] = profileList[left[i]];
    }

    //남은 맴버들 list에 넣어두고 추가하기
    for (int i = 0; i < leftProfile.length; i++) {
      await _profile.get().then((QuerySnapshot qs1) {
        qs1.docs.forEach((documentSnapshot) async {
          if (documentSnapshot.id == leftProfile[i]) {
            List<dynamic> exportRow = [];
            exportRow.add(documentSnapshot.id);
            exportRow.add(groupNumber * (-1));
            exportRow.add(documentSnapshot["name"]);
            exportRow.add(documentSnapshot["email"]);
            exportRow.add(registeredFriend[documentSnapshot.id]);
            exportRow.add(documentSnapshot["registeredClass"]);

            exportData.add(exportRow);
          }
        });
      });
    }

    // await FirebaseFirestore.instance
    //     .collection(semId)
    //     .doc(semId)
    //     .collection("Group")
    //     .doc((-1 * groupNumber).toString())
    //     .set({
    //   'meeting': 0,
    //   'imageUrl': "",
    //   'members': FieldValue.arrayUnion(leftProfile),
    //   'no': 0,
    //   'sem': semester,
    //   'time': 0,
    //   'year': year,
    // });

    //create extra group
    // for (int i = 0; i < 4; i++) {
    //   groupNumber--;
    //   await FirebaseFirestore.instance
    //       .collection(semId)
    //       .doc(semId)
    //       .collection("Group")
    //       .doc((-1 * groupNumber).toString())
    //       .set({
    //     'meeting': 0,
    //     'imageUrl': "",
    //     'members': [],
    //     'no': 0,
    //     'sem': semester,
    //     'time': 0,
    //     'year': year,
    //   });
    // }
    String sem = "";
    await FirebaseFirestore.instance
        .collection("year")
        .doc(semId)
        .get()
        .then((value) {
      sem += value["year"].toString() + "_" + value["semester"].toString();
      Get.dialog(
        AlertDialog(
          title: Text("study 결과를 export 하시겠습니까?"),
          content: Text("예를 누르면 결과가 다운로드 됩니다."),
          actions: [
            TextButton(
              onPressed: () async {
                exportResultReal(exportData, sem);
              },
              child: Text("예"),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
              },
              child: Text("닫기"),
            ),
          ],
        ),
      );
    });
  } else {
    await Get.snackbar(
      "학기 정보가 없습니다.",
      "Home 화면으로 이동 후 다시 mypage로 오십시오",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
  }
}
