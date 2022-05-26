import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class ImagePickerService extends GetxService {
  static ImagePickerService imagePickerService = ImagePickerService();
  final firestorage = FirebaseStorage.instance;

  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?>pickImage()async{
    return await _imagePicker.pickImage(source: ImageSource.gallery);
  }

  uploadImage(XFile xFile, String groupNum, String dateTime) async {
    Uint8List bytes = await xFile.readAsBytes();
    Reference ref = firestorage.ref().child('Group' + groupNum).child(dateTime + '.png');
    print(xFile.path.toString());
    await ref.putData(bytes,SettableMetadata(contentType: 'image/png'));
  }

  Future<String> downloadURL(String groupNum, String dateTime) async {
    // print("[SERIVCE]" + dateTime.toString());
    String downloadURL = await firestorage
        .ref()
        .child('Group' + groupNum)
        .child('$dateTime.png')
        .getDownloadURL();
    // print("[SERIVCE]" + downloadURL);
    return downloadURL;
  }
}