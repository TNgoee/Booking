import 'package:appthoitiet/model/database.dart';
import 'package:appthoitiet/pages/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Stream? employeeStream; // Đảm bảo biến stream đã được khai báo và khởi tạo
  getontheload() async {
    employeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

//lắng nghe 1 stream và tự động cập nhật
  Widget allEmployeeDetails() {
    return StreamBuilder(
        //Dòng dữ liệu (stream) được truyền vào từ employeeStream
        stream: employeeStream,
        //AsyncSnapshot snapshot chứa dữ liệu và trạng thái của stream
        builder: (context, AsyncSnapshot snapshot) {
          //Kiểm tra nếu snapshot có dữ liệu. Nếu có, hiển thị danh sách nhân viên bằng cách sử dụng ListView.builder.
          return snapshot.hasData
              ? ListView.builder(
//Đếm số tài liệu (document) có trong snapshot để xác định số lượng mục trong danh sách.
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    //Lấy tài liệu hiện tại tại vị trí index từ danh sách dữ liệu.
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name:" + ds["Name"],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      nameController.text = ds["Name"];
                                      ageController.text = ds["Age"];
                                      locationController.text = ds["Location"];
                                      EditEmployee(ds["Id"]);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Age:" + ds["Age"],
                                    style: const TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .deleteEmployeeDetail(ds["Id"]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Location:" + ds["Location"],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 26, 5, 83),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              // Kiểm tra khi không có dữ liệu:
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Employee()));
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent, // Đặt màu nền thành trong suốt
            elevation: 0, // Bỏ bóng đổ để làm cho gradient trông rõ hơn
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffB81736), Color(0xff281537)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: [
                // giúp allEmployeeDetails() chiếm toàn bộ không gian còn lại.
                Expanded(child: allEmployeeDetails()),
              ],
            ),
          )),
    );
  }

  Future EditEmployee(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            // Thêm SingleChildScrollView để tránh lỗi tràn màn hình
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Giới hạn kích thước của cột theo nội dung
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Map<String, dynamic> updateInfo = {
                  "Name": nameController.text,
                  "Age": ageController.text,
                  "Id": id,
                  "Location": locationController.text,
                };
                await DatabaseMethods()
                    .updateEmployeeDetail(id, updateInfo)
                    .then((value) {
                  Navigator.pop(context);
                });
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
