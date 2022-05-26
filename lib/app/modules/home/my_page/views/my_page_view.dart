import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'package:get/get.dart';
import 'package:histudy/app/modules/home/my_page/views/my_page_setting.dart';
import 'package:histudy/app/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../routes/app_pages.dart';
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

    return Scaffold(
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
                              onPressed: () async{
                              await launchUrl(Uri.parse("https://fish-gooseberry-dad.notion.site/Histudy-Guideline-866b2e628da247bcac615924fd718667"));
                            },
                              child: Text("GUIDELINE")),
                          ElevatedButton(
                              onPressed: () {
                                AuthService.to.googleSignOut();
                                Get.rootDelegate.toNamed(Routes.LOGIN);
                              },
                              child: Text('LOGOUT'))
                        ],
                      ),
                    ]),
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
                            Text("마이 페이지",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300)),
                            SizedBox(
                              width: 180,
                            ),
                            IconButton(
                              onPressed: () {
                                //controller.changed_enabled();

                                Get.to(MyPageSettingView());
                              },
                              icon: Icon(
                                PhosphorIcons.pencil, // Pencil Icon
                              ),
                            )
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
                        SizedBox(height: 30),
                        StreamBuilder<DocumentSnapshot>(
                          stream: _userStream,
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            final getdata = snapshot.data;
                            if (snapshot.hasData) {
                              return getdata?['isAdmin']
                                  ? ElevatedButton(
                                      child: Text(
                                        'Create Group',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(382, 56)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        )),
                                      ),
                                      onPressed: () async {
                                        createGroup();
                                      },
                                    )
                                  : getdata?['classRegister']
                                      ? Container(
                                          child:
                                              Text("You already applied study"),
                                        )
                                      : ElevatedButton(
                                          child: Text(
                                            'Register Histudy',
                                            style: TextStyle(
                                              fontSize: 25,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(382, 56)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            )),
                                          ),
                                          onPressed: () {
                                            Get.rootDelegate
                                                .toNamed(Routes.REGISTER);
                                          },
                                        );
                            } else {
                              return Container();
                            }
                          },
                        ),
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

void createGroup() async {
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
  await Future.delayed(Duration(seconds: 2));
  print(profileList);

  //class id list
  List<String> classList = new List.generate(0, (index) => "");
  final QuerySnapshot classResult =
      await FirebaseFirestore.instance.collection('Class').get();
  final classLen = classResult.docs.length;
  final List<DocumentSnapshot> classDocs = classResult.docs;
  classDocs.forEach((classele) {
    classList.add(classele.id);
  });
  await Future.delayed(Duration(seconds: 2));

  print(classList);

  //각각 학생들 마다 classScore의 점수를 가져와야함.
  //학생 x 숫자 배열 생성하기
  var studentScore =
      List.generate(profileLen, (i) => new List.filled(classLen, 0));
  //값 가져오기
  for (int i = 0; i < profileLen; i++) {
    FirebaseFirestore.instance
        .collection("Profile")
        .doc(profileList[i])
        .collection("classScore")
        .doc("classScore")
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
  await Future.delayed(Duration(seconds: 2));

  print(studentScore);

  //학생들간의 관계도 그리기
  var graph = List.generate(
      profileLen, (i) => new List.filled(profileLen, 0, growable: false));

  for (int i = 0; i < profileLen; i++) {
    for (int j = i + 1; j < profileLen; j++) {
      int allTemp = 0;
      for (int k = 0; k < classLen; k++) {
        allTemp += studentScore[i][k] * studentScore[j][k];
      }
      graph[i][j] = allTemp;
    }
  }
  print("graph");
  print(graph);

  //group 계산해서 넣어둠.
  int allCount = profileLen;
  //현재는 4개에 맞추어져 있음.
  int groupMember = 4;
  //여기 필수로 수정해줘야함.
  int groupNumber = -1;
  print("allcount");
  print(allCount);
  print("groupMember");
  print(groupMember - 1);
  await Future.delayed(Duration(seconds: 2));
  //4개씩 끊어서 올리기

  while (allCount > groupMember) {
    //가장 큰 값을 가지고 있는 노드 확인
    //최대값 찾기
    //maxNode는 작은 순으로 해서 함.

    var max = List.generate(groupMember - 1, (i) => -1);
    var maxNode = List.generate(groupMember, (i) => -1);

    for (int i = 0; i < classLen; i++) {
      for (int j = i; j < classLen; j++) {
        if (graph[i][j] > max[0]) {
          max[0] = graph[i][j];
          maxNode[0] = i;
          maxNode[1] = j;
        }
      }
    }
    //두개의 노드가 설정 되었으면
    //그 두개의 node에서 max인거 또 찾음.

    for (int i = 0; i < classLen; i++) {
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

    for (int i = 0; i < classLen; i++) {
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
      for (int j = 0; j < allCount; j++) {
        graph[maxNode[i]][j] = groupNumber;
      }
      //firebase에 업로드 하기
      //maxNode에 잡힌 uid 불러와서 update하기
      FirebaseFirestore.instance
          .collection("Profile")
          .doc(profileList[maxNode[i]])
          .update({
        "group": groupNumber * (-1),
      });

      //group list에도 넣어야 .
      FirebaseFirestore.instance
          .collection("Group")
          .doc((-1 * groupNumber).toString())
          .set({
        'meeting': 0,
        'members': [
          profileList[maxNode[0]],
          profileList[maxNode[1]],
          profileList[maxNode[2]],
          profileList[maxNode[3]],
        ],
        'no': 0,
        'sem': 0,
        'time': 0,
        'year': 2022,
      });
    }

    groupNumber--;
    allCount -= 4;
  }

  //남은 학생들 그룹에 넣기

  int temp = 0;
  var left = List.generate(4, (i) => -1);

  for (int i = 0; i < profileLen; i++) {
    if (graph[i][0] >= 0) {
      for (int j = 0; j < profileLen; j++) {
        graph[i][j] = groupNumber;
      }
      FirebaseFirestore.instance
          .collection("Profile")
          .doc(profileList[i])
          .update({
        "group": groupNumber * (-1),
      });
      left[temp] = i;
      temp++;
    }
  }

  var leftProfile = List.generate(temp, (index) => "");

  for (int i = 0; i < temp; i++) {
    leftProfile[i] = profileList[left[i]];
  }

  //남은 맴버들 list에 넣어두고 추가하기
  FirebaseFirestore.instance
      .collection("Group")
      .doc((-1 * groupNumber).toString())
      .set({
    'meeting': 0,
    'members': FieldValue.arrayUnion(leftProfile),
    'no': 0,
    'sem': 0,
    'time': 0,
    'year': 2022,
  });

  //create extra group
  for (int i = 0; i < 4; i++) {
    groupNumber--;
    FirebaseFirestore.instance
        .collection("Group")
        .doc((-1 * groupNumber).toString())
        .set({
      'meeting': 0,
      'members': [],
      'no': 0,
      'sem': 0,
      'time': 0,
      'year': 2022,
    });
  }
  Get.snackbar("그룹 배정 완료", "DB를 확인하세요");
}
