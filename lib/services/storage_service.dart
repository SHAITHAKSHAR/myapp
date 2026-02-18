import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfilePicture(String userId, File image) async {
    try {
      final ref = _storage.ref().child('profile_pictures').child(userId);
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
