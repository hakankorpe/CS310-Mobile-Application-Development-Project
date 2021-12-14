import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
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
      await storage
          .ref('${imageID}.png')
          .writeToFile(downloadToFile);

      print("Image has downloaded!");
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
  }
}
