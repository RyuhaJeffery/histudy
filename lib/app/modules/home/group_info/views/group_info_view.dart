import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/group_info_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

//class GroupInfoView extends GetView<GroupInfoController> {
//class GroupInfoView extends StatelessWidget {
class GroupInfoView extends StatefulWidget {
  const GroupInfoView({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<GroupInfoView> {
  //var firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String admin = '';

  void getData() async{
    User? user = _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('Profile')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
          setState(() {

            admin = userData.data()!['isAdmin'].toString();
          });
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
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

    //firebaseUser.uid.collection('Profile');
    return Scaffold(
     body:
     // SingleChildScrollView(
     //    child: Column(
     //     children: [
     //       Text(
     //         'Student List',
     //         style: TextStyle(fontSize: 25),
     //       ),
     //     SizedBox(height: 5),
     //
     //     Expanded(
     //     child:
        StreamBuilder(
              stream: _profile.snapshots(),
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
                            //title: Text(documentSnapshot['name']),
                            title: Row(
                                children: <Widget>[
                                  //null값 수정 필
                                  Expanded(child: Text('${index+1}')),
                                  //Expanded(child: Text(admin)),

                                  Expanded(child: Text(documentSnapshot['name'])),
                                  Expanded(child: Text(documentSnapshot['email'].toString())),
                                  Expanded(child: Text(documentSnapshot['group'].toString())),
                                  Expanded(child: Text(documentSnapshot['isAdmin'].toString())),
                                ]
                            ),
                            //documentSnapshot['isAdmin'].toString() ?
                              //
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
                //else {
                //   return const Center(
                //   child: CircularProgressIndicator());
                // }
                //
                 return const Center(
                   child: CircularProgressIndicator(),
                 );
              },
            )
    );
    //      ),
    //        SizedBox(height: 100),
    //      ],
    //    ),
    //  ),
    //   // Add new product
    //
    // );
  }
}
