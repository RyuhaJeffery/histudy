import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histudy/app/widgets/top_bar_widget.dart';
import '../controllers/group_info_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../routes/app_pages.dart';


class GroupInfoView extends StatefulWidget {
  const GroupInfoView({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<GroupInfoView> {
  //var firebaseUser = FirebaseAuth.instance.currentUser;
  // final FirebaseAuth _firebaseAuth =
  User? user = FirebaseAuth.instance.currentUser;

  bool admin = false ;
  int curuser = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('Profile')
        .doc( user?.uid).get()
        .then((DocumentSnapshot ds){
      setState(() {
        admin = ds['isAdmin'];
        curuser = ds['group'];
      });
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final CollectionReference _profile = FirebaseFirestore.instance.collection('Profile');

  bool isSwitched=false;
  User? currentUser;

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      isSwitched = documentSnapshot['isAdmin'];
      _nameController.text = documentSnapshot['name'];
      _groupController.text = documentSnapshot['group'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _groupController,
                  decoration: const InputDecoration(
                    labelText: 'change group number ',
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.grey,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    //final String? name = _nameController.text;
                    final double? group =
                    double.tryParse(_groupController.text);
                    if (group != null) {
                      if (action == 'update') {
                        await _profile
                            .doc(documentSnapshot!.id)
                            .update({ "group": group,"isAdmin":isSwitched});
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _groupController.text ='';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }


  Future<void> _deleteProduct(String productId) async {
    await _profile.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a profile')));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color(0xffFDFFFE),
        body:
        Column(
            children:[
              topBar(),

              SizedBox(
                height: 30.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '팀 멤버',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.black87),),


              ]),
              SizedBox(
                height: 30,
              ),
              admin ? Flexible(
                child: Padding(
                  padding:const EdgeInsets.fromLTRB(80, 20, 80,0),
                  child: Column(
                      children:[
                        Divider(
                          thickness: 0.1,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 230.w,
                              ),
                              Expanded(child:Text('  이름',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),)),
                              Expanded(child: Text('  이메일',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),)),
                              Expanded(child: Text('  그룹',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),)),
                              Expanded(child: Text('  관리자',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),)),
                              SizedBox(
                                width: 180.w,
                              ),
                            ]
                        ) ,
                        Divider(
                          thickness: 0.1,
                          color: Colors.black,
                          height: 10,
                        ),
                        Flexible(
                          child: StreamBuilder(
                            //stream: _profile.snapshots(),
                            stream: _profile.orderBy('group',descending: true).snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return ListView.builder(
                                  itemCount: streamSnapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                    return Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                          children:[
                                            ListTile(
                                              // title: Text(documentSnapshot['name']),
                                              title: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(child: Text('${index+1}')),
                                                    Expanded(child: Text(documentSnapshot['name'])),
                                                    Expanded(child: Text(documentSnapshot['email'].toString())),

                                                    Expanded(child: Text('   Group ${documentSnapshot['group'].toString()}')),
                                                    Expanded(child: Text(documentSnapshot['isAdmin'].toString())),
                                                  ]
                                              ),
                                              // documentSnapshot['isAdmin'].toString() ?

                                              trailing:  SizedBox(
                                                width: 100,
                                                child: Row(
                                                  children: [

                                                    IconButton(
                                                        icon: const Icon(Icons.edit),
                                                        onPressed: () =>
                                                            _createOrUpdate(documentSnapshot)),
                                                    IconButton(
                                                        icon: const Icon(Icons.delete),
                                                        onPressed: () =>
                                                            _deleteProduct(documentSnapshot.id)),
                                                  ],
                                                ),
                                              ),

                                            ),
                                          ]
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ]),
                ),
              ) :Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 20, 80,0),
                    child: Column(
                        children:[
                          Divider(
                            thickness: 0.1,
                            color: Colors.black,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child:Text('      NO',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)),
                                Expanded(child:Text('  이름',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),)),
                                Expanded(child: Text('  이메일',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),)),
                                Expanded(child: Text('  그룹 번호',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),)),

                              ]
                          ) ,
                          Divider(
                            thickness: 0.1,
                            color: Colors.black,
                            height: 10,
                          ),
                          Flexible(
                            child: StreamBuilder(
                              stream: _profile.where("group",isEqualTo: curuser).snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        child: Column(
                                            children:[
                                              ListTile(
                                                  title: Row(
                                                      children: <Widget>[
                                                        Expanded(child: Text('${index+1}')),
                                                        Expanded(child: Text(documentSnapshot['name'])),
                                                        Expanded(child: Text(documentSnapshot['email'].toString())),
                                                        SizedBox(width: 100.w),
                                                        Expanded(child: Text('Group ${documentSnapshot['group'].toString()}')),
                                                      ]
                                                  )

                                              ),
                                            ]
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ), ]),
                  ))

            ]
        )
    );
  }
}