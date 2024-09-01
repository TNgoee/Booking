import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  get context => null;

  Future addEmployeeDetail(
      //employeeInfoMap là 1 đối tượng Map chưá các thông tin
      //async chỉ ra rằng phương thức này là một phương thức bất đồng bộ.
      Map<String, dynamic> employeeInfoMap,
      String id) async {
    try {
      //truy cập vào fire base store
      await FirebaseFirestore.instance
          //tạo ra bộ dữ liệu có tên là Employee
          .collection('Employee')
          //xác định id
          .doc(id)
          //thêm hoặc cập nhật dữ liệu
          .set(employeeInfoMap);
      print('Employee added successfully');
    } catch (e) {
      print('Error adding employee: $e');
    }
  }

// Một QuerySnapshot đại diện cho kết quả của một truy vấn trên Firestore, có thể bao gồm nhiều tài liệu (documents) từ bộ sưu tập.
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  Future updateEmployeeDetail(
      String Id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection('Employee')
        .doc(Id)
        .update(updateInfo);
  }

  Future deleteEmployeeDetail(String Id) async {
    return FirebaseFirestore.instance.collection('Employee').doc(Id).delete();
  }
}
