import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadImage(File image) async {
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = storage.ref().child('images/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return '';
  }
}






