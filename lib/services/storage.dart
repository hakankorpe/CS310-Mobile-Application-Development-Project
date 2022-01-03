import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadProfilePict(File imageToUpload, String uid) async {
    try {
      await storage.ref("/${uid}.png").putFile(File(imageToUpload.path));
      print("Profile image of ${uid} has been uploaded.");
    } on FirebaseException catch (e) {
      print(e.code);
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> uploadProductPict(File imageToUpload, String productID) async {
    try {
      await storage.ref("/${productID}.png").putFile(File(imageToUpload.path));
      print("Profile image of ${productID} has been uploaded.");
    } on FirebaseException catch (e) {
      print(e.code);
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> downloadImage(String imageID) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/${imageID}.png');

    try {
      await storage.ref('${imageID}.png').writeToFile(downloadToFile);

      print("Image has downloaded!");
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);

      //await storage.ref('avatar.png').writeToFile(downloadToFile);
    }
  }

  Future<Image> returnImage(String imageId) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/${imageId}.png');

    if (!await downloadToFile.exists()) {
      await downloadImage(imageId);
      imageCache!.clear();
      imageCache!.clearLiveImages();
    }

    return returnCheckedImage(downloadToFile);
  }

  static Image returnCheckedImage(File file,
      {double height = 128, double width = 128}) {
    try {
      return Image.file(
        file,
        height: height,
        width: width,
      );
    } catch (err) {
      Uint8List blankBytes = const Base64Codec().decode(
          "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
      return Image.memory(blankBytes, height: height, width: width);
    }
  }
}
