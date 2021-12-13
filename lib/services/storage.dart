import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadProfilePict(XFile imageToUpload, String uid) async {
    try {
      await storage.ref("/${uid}.png").putFile(File(imageToUpload.path));
      print("Profile image of ${uid} has been uploaded.");
    } on FirebaseException catch (e) {
      print(e.code);
      // e.g, e.code == 'canceled'
    }
  }
}
