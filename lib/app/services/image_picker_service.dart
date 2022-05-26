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
