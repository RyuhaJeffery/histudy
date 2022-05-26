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