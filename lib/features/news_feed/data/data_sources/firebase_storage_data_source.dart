import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseStorageDataSource {
  Future<String> uploadFile({required String userId, required String filePath});
}

class FirebaseStorageDataSourceImpl implements FirebaseStorageDataSource {
  final FirebaseStorage _firebaseStorage;

  FirebaseStorageDataSourceImpl(this._firebaseStorage);
  @override
  Future<String> uploadFile(
      {required String userId, required String filePath}) async {
    final storageRef = _firebaseStorage
        .ref(userId)
        .child("${DateTime.timestamp().toString()}.jpg");
    File file = File(filePath);
    try {
      await storageRef.putFile(file);
      return await storageRef.getDownloadURL();
    } catch (e) {
      log(e.toString());
      return Future.error(0);
    }
  }
}
