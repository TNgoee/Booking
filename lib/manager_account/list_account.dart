import 'dart:io';
import 'dart:typed_data';

import 'package:appthoitiet/Category/add_category.dart';
import 'package:appthoitiet/Color/add_color.dart';

import 'package:appthoitiet/Product/list_product.dart';
import 'package:appthoitiet/Size/add_size.dart';
import 'package:appthoitiet/model/account_model.dart';
import 'package:appthoitiet/model/database.dart';
import 'package:appthoitiet/pages/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ListAccount extends StatefulWidget {
  const ListAccount({super.key});

  @override
  State<ListAccount> createState() => _ListAccountState();
}

class _ListAccountState extends State<ListAccount> {
  //Đây là lớp mà bạn đã định nghĩa để quản lý các chức năng liên quan đến tài khoản,
  // như tải ảnh lên Firebase và lấy thông tin nhân viên.
  final AccountService _accountService = AccountService();
  //Bạn đã khai báo một biến _stream để lưu trữ Stream của QuerySnapshot, mà bạn sẽ sử dụng để lắng nghe các cập nhật dữ liệu từ Firestore
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('User').snapshots();
  }

  Future<void> pickAndUploadImage(String documentId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? picture = await picker.pickImage(source: ImageSource.gallery);

    if (picture != null) {
      bool? confirm = await _showConfirmDialog();
      if (confirm == true) {
        String downloadUrl;
        if (kIsWeb) {
          Uint8List imageData = await picture.readAsBytes();
          downloadUrl = await _accountService.uploadImageDataToFirebase(
              imageData, picture.name);
        } else {
          File imageFile = File(picture.path);
          downloadUrl = await _accountService.uploadFileToFirebase(imageFile);
        }

        await FirebaseFirestore.instance
            .collection('User')
            .doc(documentId)
            .update({'image': downloadUrl});
        setState(() {});
      } else {
        print('User cancelled the image upload.');
      }
    } else {
      print('No image selected.');
    }
  }

  Future<bool?> _showConfirmDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to upload this image?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Employee()),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 61, 165, 239),
                  Color.fromARGB(255, 22, 21, 55)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                'List Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Manage',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                title: const Text('List Color'),
                onTap: () {
                  //phương thức chuyển hướng người dùng sang trang khác
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //hàm trả về màn hình mới
                      builder: (context) => const ColorModel(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('List Category'),
                onTap: () {
                  //phương thức chuyển hướng người dùng sang trang khác
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //hàm trả về màn hình mới
                      builder: (context) => const AddCategory(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('List Size'),
                onTap: () {
                  //phương thức chuyển hướng người dùng sang trang khác
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //hàm trả về màn hình mới
                      builder: (context) => const SizeModel(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('List Product'),
                onTap: () {
                  //phương thức chuyển hướng người dùng sang trang khác
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //hàm trả về màn hình mới
                      builder: (context) => const ListProdcut(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('List Account'),
                onTap: () {
                  //phương thức chuyển hướng người dùng sang trang khác
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //hàm trả về màn hình mới
                      builder: (context) => const ListAccount(),
                    ),
                  );
                },
              ),
            ],
            // Thêm các ListTile khác ở đây nếu cần
          ),
        ),
        body: _stream == null
            ? const Center(child: CircularProgressIndicator())
            : StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Some error occurred: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> document = querySnapshot.docs;
                    List<Map<String, dynamic>> items = document.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return {
                        'documentId': doc.id,
                        'name': data['name'] ?? 'No Name',
                        'age': data['age'] ?? 'Unknown Age',
                        'image': data['image'] ?? '',
                      };
                    }).toList();

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> thisItems = items[index];
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          leading: GestureDetector(
                            onTap: () {
                              pickAndUploadImage(thisItems['documentId']);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: thisItems["image"] != null &&
                                      thisItems["image"].isNotEmpty
                                  ? NetworkImage(thisItems["image"])
                                  : null,
                              child: thisItems["image"] == null ||
                                      thisItems["image"].isEmpty
                                  ? Icon(Icons.person,
                                      color: Colors.grey.shade700)
                                  : null,
                            ),
                          ),
                          title: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${thisItems['name']}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "${thisItems['age']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
      ),
    );
  }
}
