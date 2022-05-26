import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/announce_controller.dart';

class AnnounceView extends GetView<AnnounceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDFFFE),
      body: Center(
        child:
        Container(
          child:Column(children: [
            topBar(),

            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  SizedBox(width: 150,),
                  Text('공지사항'),]
            ),




          ],
          ),
        ),
      ),
    );
  }
}