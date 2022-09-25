import 'dart:convert';
import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/group_create_controller.dart';

// class GroupCreateView extends GetView<GroupCreateController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GroupCreateView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           'GroupCreateView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

class GroupCreateView extends StatefulWidget {
  const GroupCreateView({Key? key}) : super(key: key);

  @override
  State<GroupCreateView> createState() => _GroupCreateViewState();
}

class _GroupCreateViewState extends State<GroupCreateView> {
  late List<List<dynamic>> studentData;

  Future _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['csv']);
    if (result != null) {
      //decode bytes back to utf8
      final bytes = utf8.decode((result.files.first.bytes)!.toList());
      setState(() {
        //from the csv plugin
        studentData =
            CsvToListConverter(eol: "\r\n", fieldDelimiter: ",").convert(bytes);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentData = List<List<dynamic>>.empty(growable: true);
  }

  void exportCsvNext(Map<String, String> registeredFriend) async {
    final CollectionReference _profile =
        FirebaseFirestore.instance.collection('Profile');
    List<String> exportHeader = [
      "id",
      "group",
      "name",
      "email",
      "friend",
      "classScore",
    ];
    List<List<dynamic>> exportData = [];

    exportData.add(exportHeader);
    await _profile.get().then((QuerySnapshot qs1) {
      qs1.docs.forEach((documentSnapshot) async {
        if (documentSnapshot['classRegister'] == true) {
          List<dynamic> exportRow = [];
          exportRow.add(documentSnapshot.id);
          exportRow.add(documentSnapshot["group"]);
          exportRow.add(documentSnapshot["name"]);
          exportRow.add(documentSnapshot["email"]);
          exportRow.add(registeredFriend[documentSnapshot.id]);
          exportRow.add(documentSnapshot["registeredClass"]);

          exportData.add(exportRow);
        }
      });
    });
    Get.snackbar("convert를 실행하세요", "예 버튼을 누르고 실행하세요.");

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
      ..download = 'studentInfo.csv';
//finally add the csv anchor to body
    html.document.body!.children.add(anchor);
// Cause download by calling this function
    anchor.click();
//revoke the object
    html.Url.revokeObjectUrl(url);
  }

  void exportCsv() async {
    String? semId = Get.rootDelegate.parameters['semId'];

    final CollectionReference _profile =
        FirebaseFirestore.instance.collection('Profile');
    await Get.snackbar(
      "잠시만 기다려 주세요",
      "리스트 생성중입니다.",
      backgroundColor: Color(0xff04589C),
      colorText: Color(0xffF0F0F0),
    );
    // String registeredFriend = "";
    Map<String, String> registeredFriend = {};
    await _profile.get().then((QuerySnapshot qs1) {
      qs1.docs.forEach((documentSnapshot) async {
        if (documentSnapshot['classRegister'] == true) {
          //같이하기로한 친구 불러오기
          String tempData = "";
          _profile
              .doc(documentSnapshot.id)
              .collection(semId!)
              .get()
              .then((QuerySnapshot qs) {
            qs.docs.forEach((doc) {
              tempData +=
                  doc["name"] + "/" + doc["studentNumber"] + "/" + doc.id + "/";
            });
            setState(() {
              Map<String, String> tempMap = {documentSnapshot.id: tempData};
              registeredFriend.addAll(tempMap);
            });
          });
        }
      });
    });

    await Get.dialog(
      AlertDialog(
        title: Text("CSV파일을 다운 받으시겠습니까?"),
        // content: Text(""),
        actions: [
          TextButton(
            onPressed: () {
              exportCsvNext(registeredFriend);
              Get.back();
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
  }

  @override
  Widget build(BuildContext context) {
    String? semId = Get.rootDelegate.parameters['semId'];
    return Scaffold(
      body: Column(
        children: [
          topBar(Get.rootDelegate.parameters["semId"], context),
          Text(
            "학생들 csv를 통한 그룹관리 페이지",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff04589C),
              side: BorderSide(width: 1),
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              exportCsv();
            },
            child: Text(
              "export student study information",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff04589C),
              side: BorderSide(width: 1),
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: _openFileExplorer,
            child: Text(
              "CSV To List",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text("업로드 된 학생수 : " +
              ((studentData.isNotEmpty)
                  ? studentData.length.toString()
                  : ' 아직 비어 없습니다.')),
          // Text("classData.first.length" +
          //     ((classData.isNotEmpty)
          //         ? classData.first.length.toString()
          //         : ' is empty for now')),
          SizedBox(
            height: 20.h,
          ),

          studentData.isNotEmpty
              ? ElevatedButton(
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
                        title: Text("Firebase에 학생들 그룹 정보가 업데이트 됩니다."),
                        content: Text("기존에 올라가 있는 학생들 그룹 정보는 지워집니다."),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Get.snackbar("그룹 배정중입니다.", "종료 후 스낵바 알람이 갑니다.");

                              if (semId != null) {
                                Get.rootDelegate.toNamed(
                                  Routes.MY_PAGE,
                                  arguments: true,
                                  parameters: {'semId': semId},
                                );

                                //여기에 학생들 그룹정보 업데이트 해야함.
                                int maxNum = 0;

                                for (int i = 1; i < studentData.length; i++) {
                                  if (studentData[i][1] > maxNum) {
                                    maxNum = studentData[i][1];
                                  }
                                }

                                Get.snackbar("최대 그룹 수는 $maxNum 개 입니다.", "");

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
                                //maxNum 갯수 만큼 group 생성하기
                                for (int i = 1; i < maxNum + 5; i++) {
                                  await FirebaseFirestore.instance
                                      .collection(semId)
                                      .doc(semId)
                                      .collection("Group")
                                      .doc((i).toString())
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

                                for (int i = 1; i < studentData.length; i++) {
                                  if (i % 20 == 0) {
                                    Get.snackbar("$i 번째 학생 배정중", "");
                                  }
                                  // print("$i : ${studentData[i][2]}");
                                  //이전 데이터 가져오기
                                  // String userGroupNum = "";
                                  // await FirebaseFirestore.instance
                                  //     .collection("Profile")
                                  //     .doc(studentData[i][0])
                                  //     .get()
                                  //     .then((DocumentSnapshot ds1) {
                                  //   userGroupNum = ds1['group'].toString();
                                  // });
                                  // if (int.parse(userGroupNum) != 0) {
                                  // await FirebaseFirestore.instance
                                  //     .collection(semId)
                                  //     .doc(semId)
                                  //     .collection('Group')
                                  //     .doc(userGroupNum)
                                  //     .get()
                                  //     .then((value) {
                                  //   if (value.exists) {
                                  //     FirebaseFirestore.instance
                                  //         .collection(semId)
                                  //         .doc(semId)
                                  //         .collection('Group')
                                  //         .doc(userGroupNum)
                                  //         .update({
                                  //       "members": FieldValue.arrayRemove(
                                  //           [studentData[i][0]])
                                  //     });
                                  //   }
                                  // });
                                  //이동할 그룹에 유저 데이터를 추가
                                  await FirebaseFirestore.instance
                                      .collection(semId)
                                      .doc(semId)
                                      .collection('Group')
                                      .doc(studentData[i][1].toString())
                                      .update({
                                    "members": FieldValue.arrayUnion(
                                        [studentData[i][0]]),
                                  });
                                  await FirebaseFirestore.instance
                                      .collection("Profile")
                                      .doc(studentData[i][0])
                                      .update({
                                    "group": studentData[i][1],
                                  });
                                  // }
                                }
                              }

                              Get.snackbar(
                                "그룹 정보 업로드 완료",
                                "DB에서 정보를 확인하세요",
                                backgroundColor: Color(0xff04589C),
                                colorText: Color(0xffF0F0F0),
                              );
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
                  child: Text("upload to firebase"),
                )
              : Container(),
          SizedBox(
            height: 20.h,
          ),
          studentData.isNotEmpty
              ? Text(
                  "불러온 학생들 그룹 정보",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: studentData.length,
                itemBuilder: (context, index) {
                  if (index != 0) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: studentData[index].map((e) {
                            return Text(e.toString());
                          }).toList(),
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}
