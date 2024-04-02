import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String?> uploadFile(File imgPath, String refPath) async {
    try {
      final metaDAta = SettableMetadata(contentType: "image/jpeg");
      await _storage.ref(refPath).putFile(imgPath, metaDAta);
      String url = await _storage.ref(refPath).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.code);
      return null;
    }
  }

  Future<String?> uploadVideo(File imgPath, String refPath) async {
    try {
      final metaDAta = SettableMetadata(contentType: "image/mp4");
      await _storage.ref(refPath).putFile(imgPath, metaDAta);
      String url = await _storage.ref(refPath).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.code);
      return null;
    }
  }

  Future<String?> uploadFiles(String imgPath, String refPath) async {
    try {
      await _storage.ref(refPath).putFile(File(imgPath));
      String url = await _storage.ref(refPath).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.code);
      return null;
    }
  }

  Future<void> deleteFileFromUrl(String url) async {
    try {
      await _storage.refFromURL(url).delete();
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.code);
    }
  }

  Future<void> deleteFileFromPath(String path) async {
    try {
      await _storage.ref(path).delete();
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.code);
    }
  }
}
