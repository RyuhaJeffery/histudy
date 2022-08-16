import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/top_bar_widget.dart';
import '../controllers/edit_class_controller.dart';

class EditClassView extends StatefulWidget {
  const EditClassView({Key? key}) : super(key: key);

  @override
  State<EditClassView> createState() => _EditClassViewState();
}

class _EditClassViewState extends State<EditClassView> {
  late List<List<dynamic>> classData;

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
        classData =
            CsvToListConverter(eol: "\r\n", fieldDelimiter: ",").convert(bytes);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    classData = List<List<dynamic>>.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    String? semId = Get.rootDelegate.parameters['semId'];
    return Scaffold(
      body: Column(
        children: [
          topBar(Get.rootDelegate.parameters["semId"]),
          Text(
            "CSV파일 불러온 후 Firebase 업로드",
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
            onPressed: _openFileExplorer,
            child: Text(
              "CSV To List",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text("업로드 된 class 갯수 : " +
              ((classData.isNotEmpty)
                  ? classData.length.toString()
                  : ' 아직 비어 없습니다.')),
          // Text("classData.first.length" +
          //     ((classData.isNotEmpty)
          //         ? classData.first.length.toString()
          //         : ' is empty for now')),
          SizedBox(
            height: 20.h,
          ),

          classData.isNotEmpty
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
                        title: Text("Firebase에 수업 정보가 업로드 됩니다"),
                        content: Text("기존에 올라가 있는 수업 정보는 지워집니다."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (semId != null) {
                                int? year;
                                int? semester;
                                FirebaseFirestore.instance
                                    .collection('year')
                                    .doc(semId)
                                    .get()
                                    .then((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  year = data['year'];
                                  semester = data['semester'];
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection('Class')
                                      .doc(semId)
                                      .set({
                                    'year': year,
                                    'semester': semester,
                                    'semId': semId,
                                  });
                                });

                                CollectionReference classFirestore =
                                    FirebaseFirestore.instance
                                        .collection('Class')
                                        .doc(semId)
                                        .collection("subClass");
                                classFirestore.get().then((snapshot) {
                                  for (DocumentSnapshot ds in snapshot.docs) {
                                    ds.reference.delete();
                                  }
                                }).then((value) {
                                  for (int i = 1; i < classData.length; i++) {
                                    classFirestore.add({
                                      'class': classData[i][0],
                                      'code': classData[i][1],
                                      'professor': classData[i][2],
                                      'year': classData[i][3],
                                      'semester': classData[i][4],
                                    });
                                  }
                                });
                              }
                              Get.snackbar(
                                "수업 업로드 완료",
                                "DB에서 정보를 확인하세요",
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
                  child: Text("upload to firebase"))
              : Container(),
          SizedBox(
            height: 20.h,
          ),
          classData.isNotEmpty
              ? Text(
                  "불러온 수업 정보",
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
                itemCount: classData.length,
                itemBuilder: (context, index) {
                  if (index != 0) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: classData[index].map((e) {
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
