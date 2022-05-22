import 'dart:io';
import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase/firebase.dart' as fb;

class ImagePickerService {
  static final ImagePickerService _instance = ImagePickerService._internal();

  // final _androidUiSettings = const AndroidUiSettings(
  //   initAspectRatio: CropAspectRatioPreset.original,
  //   lockAspectRatio: false,
  //   showCropGrid: true,
  //   hideBottomControls: true,
  // );
  // final _iosUiSettings = const IOSUiSettings(
  //   hidesNavigationBar: true,
  // );

  factory ImagePickerService() {
    return _instance;
  }
  ImagePickerService._internal();

  final ImagePicker picker = ImagePicker();

  // Future<void> uploadFile(String uid, html.File pickedImage) async {
  //   // File file = File(pickedImage.relativePath.toString());
  //   await FirebaseStorage.instance.ref().child('reportPhoto').child('$uid.png').putData(pickedImage);
  //   FirebaseStorage.instance.
  // }

  // Future<Uri> uploadImageFile(html.File image, String uid) async {
  //   fb.StorageReference storageRef = fb.storage().ref('reportPhoto/$uid');
  //   fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(image).future;
  //
  //   Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
  //   return imageUri;
  // }

//   uploadImageToStorage(PickedFile? pickedFile) async {
//     if(kIsWeb){
//       Reference _reference = FirebaseStorage.instance
//           .ref()
//           .child('reportPhoto/${Path.basename(pickedFile!.path)}');
//       await _reference
//           .putData(
//         await pickedFile!.readAsBytes(),
//         SettableMetadata(contentType: 'image/jpeg'),
//       )
//           .whenComplete(() async {
//         await _reference.getDownloadURL().then((value) {
//           var uploadedPhotoUrl = value;
//         });
//       });
//     }else{
// //write a code for android or ios
//     }
//   }

  // Future<File?> pickImg() async {
  //   XFile? image =
  //   await picker.pickImage(imageQuality: 90, source: ImageSource.gallery);
  //
  //   return image == null ? null : _cropImage(image.path);
  // }

  // Future<File?> _cropImage(filePath) async {
  //   File? croppedImage = await ImageCropper().cropImage(
  //       sourcePath: filePath,
  //       maxWidth: 1080,
  //       maxHeight: 1080,
  //       aspectRatioPresets: [CropAspectRatioPreset.square],
  //       cropStyle: CropStyle.circle,
  //       compressQuality: 80,
  //       androidUiSettings: _androidUiSettings
  //       iosUiSettings: _iosUiSettings
  //   );
  //
  //   return croppedImage;
  // }

  Future<String> downloadURL(String uid) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child('reportPhoto')
        .child('$uid.png')
        .getDownloadURL();
    return downloadURL;
  }
}