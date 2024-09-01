import 'package:appthoitiet/Category/add_category.dart';
import 'package:appthoitiet/Color/add_color.dart';
import 'package:appthoitiet/Product/add_product.dart';
import 'package:appthoitiet/Size/add_size.dart';
import 'package:appthoitiet/manager_account/list_account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListProdcut extends StatefulWidget {
  const ListProdcut({super.key});

  @override
  State<ListProdcut> createState() => _ListProdcutState();
}

class _ListProdcutState extends State<ListProdcut> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProduct()),
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
                    'List Product',
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
            )));
  }
}
