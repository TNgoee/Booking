import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageAndMore extends StatefulWidget {
  const UploadImageAndMore({super.key});

  @override
  State<UploadImageAndMore> createState() => _UploadImageAndMoreState();
}

class _UploadImageAndMoreState extends State<UploadImageAndMore> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  //Đại diện cho một tập hợp (collection) trong Firestore, nơi lưu trữ các mục sẽ được tải lên.
  final CollectionReference _item =
      FirebaseFirestore.instance.collection('Upload_Items');
// Một luồng dữ liệu từ Firestore, dùng để lắng nghe và hiển thị các thay đổi trong cơ sở dữ liệu theo thời gian thực.
  Stream<QuerySnapshot>? _stream;
  // Lưu trữ URL của ảnh sau khi tải lên Firebase Storage.
  String imageUrl = '';

  //Phương thức tạo một mục mới và tải ảnh lên
  //DocumentSnapshot?: Đây là tham số không bắt buộc (có thể là null), đại diện cho một tài liệu từ Firestore
  Future<void> _create([DocumentSnapshot? DocumentSnapshot]) async {
    showModalBottomSheet(
        isScrollControlled: true,
        //context: Ngữ cảnh của widget hiện tại, dùng để xác định nơi hiển thị BottomSheet.
        context: context,
        //Hàm xây dựng giao diện của BottomSheet, trả về một widget dựa trên ngữ cảnh ctx.
        builder: (BuildContext ctx) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  //. Ở đây, cạnh dưới (bottom) có khoảng cách động dựa trên vùng tránh của thiết bị (chẳng hạn như bàn phím).
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
                  TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                        labelText: 'Number', hintText: 'eg 1234'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Chọn ảnh từ thư viện
                  Center(
                    child: IconButton(
                        onPressed: () async {
                          //Mở thư viện ảnh của thiết bị để người dùng chọn một ảnh.
                          final file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file == null) return;
                          //Tạo tên file dựa trên thời gian hiện tại để đảm bảo tên là duy nhất.
                          String filename =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          //Tạo một tham chiếu đến gốc của Firebase Storage.
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          //Tạo một thư mục images trong Firebase Storage.
                          Reference referenceDirecImages =
                              referenceRoot.child('images');

                          // Tải file ảnh lên Firebase Storage.
                          Reference referenceImagetoUpload =
                              referenceDirecImages.child(filename);

                          try {
                            await referenceImagetoUpload
                                .putFile(File(file.path));

                            imageUrl =
                                await referenceImagetoUpload.getDownloadURL();
                          } catch (error) {}
                        },
                        icon: const Icon(Icons.camera_alt)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Tạo mục mới và lưu vào Firestore
                  Center(
                      //Nút bấm nâng cao, khi được bấm sẽ thực hiện hành động tạo mục mới.
                      child: ElevatedButton(
                          onPressed: () async {
                            if (imageUrl.isEmpty) {
                              //Hiển thị một thông báo (SnackBar) nếu người dùng chưa chọn ảnh.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please pick Image')));
                              return;
                            }
                            final String name = _nameController.text;
                            final int? number =
                                int.tryParse(_numberController.text);
                            if (number != null) {
                              //hêm một tài liệu mới vào Firestore với các thông tin như tên, số, và URL của ảnh.
                              _item.add({
                                "name": name,
                                "number": number,
                                "image": imageUrl,
                              });
                              _nameController.text = '';
                              _numberController.text = '';
                              //Đóng BottomSheet sau khi thêm thành công.
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Create')))
                ],
              ));
        });
  }

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Upload_Items').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, // Màu sắc của nút quay lại
          ),
          backgroundColor: Colors.transparent, // Đặt màu nền thành trong suốt

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
                'Upload and display Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        //Kiểm tra xem dữ liệu stream từ Firestore đã được khởi tạo hay chưa.
        body: _stream == null
            ? const Center(
                //Nếu chưa, hiển thị CircularProgressIndicator để thông báo rằng dữ liệu đang được tải.
                child: CircularProgressIndicator(),
              )
            //Nếu đã có dữ liệu (_stream không null), sử dụng StreamBuilder để lắng nghe và hiển thị dữ liệu từ Firestore.
            : StreamBuilder<QuerySnapshot>(
                stream: _stream,
                // Hàm xây dựng giao diện dựa trên trạng thái của AsyncSnapshot
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Some error occurred: ${snapshot.error}'),
                    );
                  }
                  //Nếu dữ liệu đã được tải thành công, hiển thị danh sách các mục.
                  if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> document = querySnapshot.docs;
                    List<Map> items =
                        document.map((e) => e.data() as Map).toList();
                    //Widget này tạo ra một danh sách có thể cuộn dựa trên số lượng mục (items.length).
                    return ListView.builder(
                        itemCount: items
                            .length, // Số lượng mục trong danh sách dựa trên số phần tử trong 'items'.
                        itemBuilder: (BuildContext context, int index) {
                          Map thisItems = items[
                              index]; // Lấy dữ liệu của từng mục từ danh sách 'items'.

                          return ListTile(
                            // Hiển thị tên của mục hiện tại (từ khóa 'name' trong 'thisItems') dưới dạng tiêu đề.
                            title: Text("${thisItems['name']}"),

                            // Hiển thị số của mục hiện tại (từ khóa 'number' trong 'thisItems') dưới dạng phụ đề.
                            subtitle: Text("${thisItems['number']}"),

                            // Hiển thị ảnh đại diện tròn cho mỗi mục:
                            leading: CircleAvatar(
                              radius: 27, // Bán kính của ảnh đại diện.
                              // Kiểm tra xem mục có ảnh hay không. Nếu có, hiển thị ảnh, nếu không thì hiển thị một avatar trống.
                              child: thisItems.containsKey('image')
                                  ? ClipOval(
                                      child: Image.network(
                                        "${thisItems['image']}", // URL của ảnh lấy từ Firestore.
                                        fit: BoxFit
                                            .cover, // Đảm bảo ảnh bao phủ toàn bộ vùng diện tích của CircleAvatar.
                                        height: 70, // Chiều cao của ảnh.
                                        width: 70, // Chiều rộng của ảnh.
                                      ),
                                    )
                                  : const CircleAvatar(), // Nếu không có ảnh, hiển thị một avatar trống.
                            ),
                          );
                        });
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
}
