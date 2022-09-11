import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histudy/app/modules/home/report_list/report_detail/controllers/report_detail_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../middleware/auth_middleware.dart';
import '../../../../models/profile_model.dart';
import '../../../../models/report_model.dart';
import '../../../../repository/report_repository.dart';
import '../../../../repository/user_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/top_bar_widget.dart';
import '../controllers/report_list_controller.dart';
import '../report_detail/controllers/report_detail_controller.dart';

// class ReportListView extends GetView<ReportListController> {
class ReportListView extends StatefulWidget {
  @override
  State<ReportListView> createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {
  late int groupNum = 1;
  final TextEditingController _groupController = TextEditingController();
  final _groupKey = GlobalKey<FormState>();

  bool admin = false;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(user.id)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        admin = ds['isAdmin'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? semId = Get.rootDelegate.parameters["semId"];

    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            topBar(Get.rootDelegate.parameters["semId"], context),
            SizedBox(
              height: 30.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //SizedBox(width: 180,),
              Text(
                "등록된 스터디모임 보고서",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ]),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 500,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff04589C),
                        side: BorderSide(width: 1),
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        if (semId != null) {
                          Get.rootDelegate.toNamed(
                            Routes.REPORT_WRITE,
                            arguments: true,
                            parameters: {
                              'semId': semId,
                            },
                          );
                        }
                      },
                      child: Text('보고서 작성')),
                ),
              ],
            ),
            admin
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection(semId!)
                        .doc(semId)
                        .collection('Group')
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        _groupController.text = groupNum.toString();

                        return Column(
                          children: [
                            Text("확인하고 싶은 그룹 정보를 입력하세요"),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 7,
                                  child: TextFormField(
                                    key: _groupKey,
                                    controller: _groupController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: "그룹 번호",
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
                                        borderSide: BorderSide(
                                            color: Color(0xFFECEFF1)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
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
                                    if (int.tryParse(_groupController.text) ==
                                        null) {
                                      Get.dialog(
                                        AlertDialog(
                                          title: Text("번호만 입력하세요"),
                                        ),
                                      );
                                      _groupController.text =
                                          groupNum.toString();
                                    } else if (int.parse(
                                                _groupController.text) <
                                            1 ||
                                        int.parse(_groupController.text) >=
                                            snapshot.data!.docs.length) {
                                      Get.dialog(
                                        AlertDialog(
                                          title: Text(
                                              "1에서 ${snapshot.data!.docs.length}까지 그룹이 있습니다."),
                                        ),
                                      );
                                      _groupController.text =
                                          groupNum.toString();
                                    } else {
                                      setState(() {
                                        groupNum =
                                            int.parse(_groupController.text);
                                      });
                                    }
                                  },
                                  child: Text('그룹 변경'),
                                ),
                              ],
                            ),
                            _reportList(groupNum),
                          ],
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  )
                : _reportList(groupNum),
          ]),
        ),
      ),
    );
  }

  _reportList(int groupNum) {
    String? semId = Get.rootDelegate.parameters['semId'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
      child: Column(
        children: [
          Divider(
            thickness: 0.1,
            color: Colors.black,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Text(
              '  No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            Expanded(
                child: Text(
              '제목',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            Expanded(
                child: Text(
              '  글쓴이',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            Expanded(
                child: Text(
              '  날짜',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
          ]),
          Divider(
            thickness: 0.1,
            color: Colors.black,
            height: 10,
          ),
          FutureBuilder<ProfileModel?>(
            future: UserRepositroy.getUser(
                AuthService.to.auth.value.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData && semId != null) {
                ProfileModel profile = snapshot.data!;
                if (profile.isAdmin!) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: ReportRepository.getReportList(
                      semId,
                      groupNum.toString(),
                    ),
                    builder: (contextTwo, reportListSnapshot) {
                      if (reportListSnapshot.hasData) {
                        List<ReportModel> reportList = reportListSnapshot
                            .data!.docs
                            .map((item) => ReportModel.fromSnapshot(item))
                            .toList();

                        return SizedBox(
                          height: 400.h,
                          child: ListView.builder(
                            itemCount: reportList.length,
                            itemBuilder:
                                (BuildContext contextThree, int index) {
                              return _reportBlock(reportList[index], index);
                            },
                          ),
                        );
                      } else {
                        return Container(
                            height: 400.h,
                            width: 400.w,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  );
                } else {
                  return StreamBuilder<QuerySnapshot>(
                    stream: ReportRepository.getReportList(
                      semId,
                      profile.group!.toString(),
                    ),
                    builder: (contextTwo, reportListSnapshot) {
                      if (reportListSnapshot.hasData) {
                        List<ReportModel> reportList = reportListSnapshot
                            .data!.docs
                            .map((item) => ReportModel.fromSnapshot(item))
                            .toList();

                        return SizedBox(
                          height: 400.h,
                          child: ListView.builder(
                            itemCount: reportList.length,
                            itemBuilder:
                                (BuildContext contextThree, int index) {
                              return _reportBlock(reportList[index], index);
                            },
                          ),
                        );
                      } else {
                        return Container(
                            height: 400.h,
                            width: 400.w,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  );
                }
              } else {
                return Container(
                    height: 400.h,
                    width: 400.w,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }

  _reportBlock(ReportModel reportModel, int index) {
    String? semId = Get.rootDelegate.parameters['semId'];
    return InkWell(
      onTap: () {
        Get.put(ReportDetailController()).arg = reportModel;
        if (semId != null) {
          Get.rootDelegate.toNamed(
            Routes.REPORT_DETAILE,
            arguments: true,
            parameters: {'semId': semId},
          );
        }
      },
      child: Container(
        height: 50.h,
        width: 1400.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              '  ${index + 1}'.toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            )),
            Expanded(
                child: Text(
              '${reportModel.title.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            )),
            Expanded(
                child: Text(
              '  ${reportModel.author.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            )),
            Expanded(
                child: Text(
              '  ${DateFormat('yyyy-MM-dd').format(reportModel.dateTime!.toDate())}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
