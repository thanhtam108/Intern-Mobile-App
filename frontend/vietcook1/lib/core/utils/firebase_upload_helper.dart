import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUploadHelper {
  static Future<String?> uploadImage({
    required File file,
    required String path,
  }) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('$path/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = await storageRef.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print("Upload failed: $e");
      return null;
    }
  }
}
