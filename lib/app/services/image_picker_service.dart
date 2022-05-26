<<<<<<< HEAD
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
  //1. 이미지 피커 -> 이미지 선택
  //2. 선택된 이미지 path
  //3.
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?>pickImage()async{
    return await _imagePicker.pickImage(source: ImageSource.gallery);
  }
  uploadImage(XFile xFile,String ref)async{
    Uint8List bytes = await xFile.readAsBytes();
    Reference ref = firestorage.ref().child('${DateTime.now()}.jpeg');
    await ref.putData(bytes,SettableMetadata(contentType: 'image/jpeg'));

  }
}
=======
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePickerService {
//   static final ImagePickerService _instance = ImagePickerService._internal();

//   final _androidUiSettings = const AndroidUiSettings(
//     initAspectRatio: CropAspectRatioPreset.original,
//     lockAspectRatio: false,
//     showCropGrid: true,
//     hideBottomControls: true,
//   );
//   final _iosUiSettings = const IOSUiSettings(
//     hidesNavigationBar: true,
//   );

//   factory ImagePickerService() {
//     return _instance;
//   }
//   ImagePickerService._internal();

//   final ImagePicker picker = ImagePicker();

//   Future<void> uploadFile(String uid, File pickedImage) async {
//     File file = File(pickedImage.path);
//     await FirebaseStorage.instance.ref().child('reportPhoto').child('$uid.png').putFile(file);
//   }

//   Future<File?> pickImg() async {
//     XFile? image =
//     await picker.pickImage(imageQuality: 90, source: ImageSource.gallery);

//     return image == null ? null : _cropImage(image.path);
//   }

//   Future<File?> _cropImage(filePath) async {
//     File? croppedImage = await ImageCropper().cropImage(
//         sourcePath: filePath,
//         maxWidth: 1080,
//         maxHeight: 1080,
//         aspectRatioPresets: [CropAspectRatioPreset.square],
//         cropStyle: CropStyle.circle,
//         compressQuality: 80,
//         androidUiSettings: _androidUiSettings
//         iosUiSettings: _iosUiSettings
//     );

//     return croppedImage;
//   }

//   Future<String> downloadURL(String uid) async {
//     String downloadURL = await FirebaseStorage.instance
//         .ref()
//         .child('reportPhoto')
//         .child('$uid.png')
//         .getDownloadURL();
//     return downloadURL;
//   }
// }
>>>>>>> subin
