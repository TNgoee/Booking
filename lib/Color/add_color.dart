import 'dart:io';

import 'package:appthoitiet/Category/add_category.dart';
import 'package:appthoitiet/Product/list_product.dart';
import 'package:appthoitiet/Size/add_size.dart';
import 'package:appthoitiet/manager_account/list_account.dart';
import 'package:appthoitiet/model/color_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ColorModel extends StatefulWidget {
  const ColorModel({super.key});

  @override
  State<ColorModel> createState() => _ColorState();
}

class _ColorState extends State<ColorModel> {
  final TextEditingController _nameController = TextEditingController();
  final CollectionReference _item =
      FirebaseFirestore.instance.collection('Color');
  final Colormodel _colormodel = Colormodel();
  Stream<QuerySnapshot>? _stream;
  String imageUrl = '';

  // Method to handle image picking and uploading
  Future<void> pickAndUploadImage(String documentId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? picture = await picker.pickImage(source: ImageSource.gallery);

    if (picture != null) {
      bool? confirm = await _showConfirmDialog();
      if (confirm == true) {
        String downloadUrl;
        try {
          if (kIsWeb) {
            Uint8List imageData = await picture.readAsBytes();
            Reference reference = FirebaseStorage.instance
                .ref()
                .child('imgColor/${picture.name}');
            await reference.putData(imageData);
            downloadUrl = await reference.getDownloadURL();
          } else {
            File imageFile = File(picture.path);
            Reference reference = FirebaseStorage.instance
                .ref()
                .child('imgColor/${DateTime.now().microsecondsSinceEpoch}');
            await reference.putFile(imageFile);
            downloadUrl = await reference.getDownloadURL();
          }

          setState(() {
            imageUrl = downloadUrl;
          });

          // Cập nhật URL ảnh trong Firebase Firestore
          await _item.doc(documentId).update({"imgColor": imageUrl});
        } catch (e) {
          print('Error uploading image: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload image.')),
          );
        }
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

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('Create your item'),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Name', hintText: 'eg Ngyn'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: IconButton(
                        onPressed: () async {
                          String tempDocumentId = randomAlphaNumeric(
                              10); // Generate a temporary document ID
                          await pickAndUploadImage(
                              tempDocumentId); // Pass the ID to the method
                        },
                        icon: const Icon(Icons.camera_alt)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (imageUrl.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please pick Image')));
                              return;
                            }
                            String Id = randomAlphaNumeric(10);
                            final String name = _nameController.text;
                            await _item.add({
                              "Id": Id,
                              "name": name,
                              "imgColor": imageUrl,
                            });
                            _nameController.text = '';
                            Navigator.of(context).pop();
                          },
                          child: const Text('Create')))
                ],
              ));
        });
  }

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Color').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                'List Color',
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Some error occurred: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> document = querySnapshot.docs;
                    List<Map> items =
                        document.map((e) => e.data() as Map).toList();
                    return ListView.builder(
                      itemCount: document.length,
                      itemBuilder: (BuildContext context, int index) {
                        QueryDocumentSnapshot thisDocument = document[index];
                        Map thisItems = thisDocument.data() as Map;

                        return ListTile(
                          title: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${thisItems['name']}"),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _nameController.text =
                                            thisItems["name"];
                                        _editCategory(thisDocument.id,
                                            thisItems); // Pass thisItems to the method
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () async {
                                        await _colormodel
                                            .showDeleteConfirmationDialog(
                                                context, thisDocument.id);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 27,
                            backgroundImage: thisItems['imgColor'] != null
                                ? NetworkImage("${thisItems['imgColor']}")
                                : null,
                            child: thisItems['imgColor'] == null
                                ? const Icon(Icons.image)
                                : null,
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _create();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _editCategory(String id, Map thisItems) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.cancel),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Detail',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickAndUploadImage(id); // Sử dụng id để cập nhật ảnh
                        },
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : thisItems['imgColor'] != null
                                  ? NetworkImage(thisItems['imgColor'])
                                  : null,
                          child: thisItems['imgColor'] == null
                              ? const Icon(Icons.image)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(hintText: 'name'),
                        ),
                      )
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          String name = _nameController.text;
                          if (name.isNotEmpty) {
                            // Kiểm tra nếu imageUrl không rỗng, dùng nó để cập nhật
                            if (imageUrl.isNotEmpty) {
                              thisItems['imgColor'] = imageUrl;
                            }
                            await _item.doc(id).update({
                              'name': name,
                              'imgColor': thisItems['imgColor']
                            });
                            setState(() {
                              imageUrl =
                                  ''; // Đặt lại imageUrl sau khi cập nhật
                            });
                            _nameController.text = '';
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill the name')));
                          }
                        },
                        child: const Text('Update'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
