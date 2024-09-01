import 'dart:io';
import 'dart:typed_data';

import 'package:appthoitiet/model/database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountService {
  // Upload ảnh từ Uint8List lên Firebase
  Future<String> uploadImageDataToFirebase(
      Uint8List imageData, String fileName) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    await storageRef.putData(imageData);
    final downloadUrl = await storageRef.getDownloadURL();
    print('File uploaded successfully: $downloadUrl');
    return downloadUrl;
  }

  // Upload ảnh từ File lên Firebase
  Future<String> uploadFileToFirebase(File file) async {
    final String fileName = file.path.split('/').last;
    final storageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    await storageRef.putFile(file);
    final downloadUrl = await storageRef.getDownloadURL();
    print('File uploaded successfully: $downloadUrl');
    return downloadUrl;
  }

  // Lấy thông tin nhân viên
  Future<Stream?> getEmployeeDetails() async {
    return await DatabaseMethods().getEmployeeDetails();
  }
}
