import 'dart:io';

import 'package:appthoitiet/Color/add_color.dart';

import 'package:appthoitiet/Product/list_product.dart';
import 'package:appthoitiet/Size/add_size.dart';
import 'package:appthoitiet/manager_account/list_account.dart';
import 'package:appthoitiet/model/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
// Import the category model

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _nameController = TextEditingController();
  final CollectionReference _item =
      FirebaseFirestore.instance.collection('Category');
  Stream<QuerySnapshot>? _stream;
  final CategoryModel _categoryModel =
      CategoryModel(); // Create an instance of CategoryModel

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
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 2),
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
                      child: ElevatedButton(
                          onPressed: () async {
                            String Id = randomAlphaNumeric(10);
                            final String name = _nameController.text;
                            _item.add({
                              "name": name,
                              "Id": Id,
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
    _stream = FirebaseFirestore.instance.collection('Category').snapshots();
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
                'List Category',
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
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Some error occurred: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = documents[index];
                        return Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(
                              bottom: 5, top: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${item['name']}"),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _nameController.text = item["name"];
                                      _editCategory(item.id);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: () async {
                                      await _categoryModel
                                          .showDeleteConfirmationDialog(context,
                                              item.id); // Pass item.id to delete method
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
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

  Future<void> _editCategory(String id) => showDialog(
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
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _categoryModel.updateCategory(id, _nameController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
}
