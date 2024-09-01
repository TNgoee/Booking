import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
                  'Add Product',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        18, 0, 0, 0), // Màu sắc và độ mờ của bóng
                    spreadRadius: 2, // Bán kính lan rộng của bóng
                    blurRadius: 2, // Bán kính làm mờ của bóng
                    offset: Offset(
                        0, 3), // Độ lệch của bóng theo chiều ngang và chiều dọc
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Basic information',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Product image',
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Text(
                              'Product image',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          )),
    );
  }
}
