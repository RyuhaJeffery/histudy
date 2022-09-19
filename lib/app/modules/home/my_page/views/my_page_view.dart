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
                  height: 650,
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
                                          height: 10.h,
                                        ),
                                        ElevatedButton(
                                          child: Text(
                                            '2022-2 부족한 데이터 추가 버튼',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(280, 40)),
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .all<Color>(Color.fromARGB(
                                                        208, 255, 0, 0)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(27),
                                            )),
                                          ),
                                          onPressed: () {
                                            Get.dialog(
                                              AlertDialog(
                                                title: Text(
                                                    "데이터 베이스에 많은 트래픽이 생깁니다."),
                                                content: Text("처음 한번만 시도하십시오"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        final CollectionReference
                                                            _profile =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Profile');
                                                        List<
                                                                Map<String,
                                                                    dynamic>>
                                                            classInfo =
                                                            List.empty(
                                                                growable: true);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Class")
                                                            .doc(semId)
                                                            .collection(
                                                                'subClass')
                                                            .get()
                                                            .then((QuerySnapshot
                                                                qs) {
                                                          qs.docs.forEach(
                                                              (element) {
                                                            var mapTemp = {
                                                              "id": element.id,
                                                              "class": element[
                                                                  "class"],
                                                              "professor":
                                                                  element[
                                                                      "professor"]
                                                            };
                                                            classInfo
                                                                .add(mapTemp);
                                                          });
                                                        });

                                                        _profile.get().then(
                                                            (QuerySnapshot
                                                                qs1) {
                                                          qs1.docs.forEach(
                                                              (documentSnapshot) {
                                                            if (documentSnapshot[
                                                                    'classRegister'] ==
                                                                true) {
                                                              String
                                                                  registeredClass =
                                                                  "true";
                                                              _profile
                                                                  .doc(
                                                                      documentSnapshot
                                                                          .id)
                                                                  .collection(
                                                                      'classScore')
                                                                  .doc(semId)
                                                                  .get()
                                                                  .then((DocumentSnapshot
                                                                      classDs) {
                                                                for (int j = 10;
                                                                    j > 0;
                                                                    j--) {
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          classInfo
                                                                              .length;
                                                                      i++) {
                                                                    if (classDs[classInfo[i]
                                                                            [
                                                                            "id"]] ==
                                                                        j) {
                                                                      registeredClass += "/" +
                                                                          classInfo[i]["class"]
                                                                              .toString() +
                                                                          "(" +
                                                                          classInfo[i]["professor"]
                                                                              .toString() +
                                                                          ")[" +
                                                                          classDs[classInfo[i]["id"]]
                                                                              .toString() +
                                                                          "]";
                                                                    }
                                                                  }
                                                                }

                                                                //여기서 각자 유저마다 올리는 작업이 필요함.
                                                                _profile
                                                                    .doc(
                                                                        documentSnapshot
                                                                            .id)
                                                                    .update({
                                                                  "registeredClass":
                                                                      registeredClass,
                                                                });
                                                              });
                                                            } else {
                                                              _profile
                                                                  .doc(
                                                                      documentSnapshot
                                                                          .id)
                                                                  .update({
                                                                "registeredClass":
                                                                    "",
                                                              });
                                                            }
                                                          });
                                                        });
                                                        Get.back();
                                                      },
                                                      child: Text("예"))
                                                ],
                                              ),
                                            );
                                          },
                                        )
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
      "약 30초간 걸릴 예정입니다. 끝나면 스낵바로 알람이 갑니다. ",
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
          for (int j = 0; j < classLen; j++) {
            studentScore[i][j] = ds[classList[j]];
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

    print(studentScore);
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
        //firebase에 업로드 하기
        //maxNode에 잡힌 uid 불러와서 update하기
        await FirebaseFirestore.instance
            .collection("Profile")
            .doc(profileList[maxNode[i]])
            .update({
          "group": groupNumber * (-1),
        });

        //group list에도 넣어야 .
        await FirebaseFirestore.instance
            .collection(semId)
            .doc(semId)
            .collection("Group")
            .doc((-1 * groupNumber).toString())
            .set({
          'meeting': 0,
          'imageUrl': "",
          'members': [
            profileList[maxNode[0]],
            profileList[maxNode[1]],
            profileList[maxNode[2]],
            profileList[maxNode[3]],
          ],
          'no': 0,
          'sem': semester,
          'time': 0,
          'year': year,
        });
      }

      Get.snackbar(
        "${groupNumber - 1}번째 그룹 생성 완료",
        "DB에서 확인하실 수 있습니다. ",
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
    await FirebaseFirestore.instance
        .collection(semId)
        .doc(semId)
        .collection("Group")
        .doc((-1 * groupNumber).toString())
        .set({
      'meeting': 0,
      'imageUrl': "",
      'members': FieldValue.arrayUnion(leftProfile),
      'no': 0,
      'sem': semester,
      'time': 0,
      'year': year,
    });

    //create extra group
    for (int i = 0; i < 4; i++) {
      groupNumber--;
      await FirebaseFirestore.instance
          .collection(semId)
          .doc(semId)
          .collection("Group")
          .doc((-1 * groupNumber).toString())
          .set({
        'meeting': 0,
        'imageUrl': "",
        'members': [],
        'no': 0,
        'sem': semester,
        'time': 0,
        'year': year,
      });
    }
    await Get.snackbar(
      "그룹 배정 완료",
      "DB를 확인하거나 혹은 Team tab을 클릭하세요",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
  } else {
    await Get.snackbar(
      "학기 정보가 없습니다.",
      "Home 화면으로 이동 후 다시 mypage로 오십시오",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
  }
}
