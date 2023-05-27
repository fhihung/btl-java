import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/borrows.dart';

class BorrowScreen extends StatefulWidget {
  @override
  _BorrowScreenState createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  List<Borrow> borrowList = [];

  @override
  void initState() {
    super.initState();
    fetchBorrowData();
  }

  Future<void> fetchBorrowData() async {
    // Đọc dữ liệu JSON từ API hoặc tệp tin
    String jsonData = '[{"id":15,"borrowDate":"2023-05-23","dueDate":"2023-06-06","returnDate":"2023-05-27"},{"id":16,"borrowDate":"2023-05-23","dueDate":"2023-05-25","returnDate":null},{"id":19,"borrowDate":"2023-05-27","dueDate":"2023-06-25","returnDate":"2023-05-27"},{"id":20,"borrowDate":"2023-05-27","dueDate":"2023-06-25","returnDate":"2023-05-27"},{"id":21,"borrowDate":"2023-05-27","dueDate":"2023-06-25","returnDate":"2023-05-27"},{"id":22,"borrowDate":"2023-05-27","dueDate":"2023-06-25","returnDate":"2023-05-27"},{"id":23,"borrowDate":"2023-05-27","dueDate":"2023-06-25","returnDate":null},{"id":24,"borrowDate":"2023-05-27","dueDate":"2023-06-25","returnDate":null}]';
    
    // Giải mã JSON thành danh sách Borrow
    List<dynamic> jsonDataList = json.decode(jsonData);
    List<Borrow> newBorrowList = jsonDataList.map((item) => Borrow.fromJson(item)).toList();

    setState(() {
      borrowList = newBorrowList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrow List'),
      ),
      body: ListView.builder(
        itemCount: borrowList.length,
        itemBuilder: (context, index) {
          Borrow borrow = borrowList[index];

          return ListTile(
            title: Text('ID: ${borrow.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Borrow Date: ${borrow.borrowDate}'),
                Text('Due Date: ${borrow.dueDate}'),
                Text('Return Date: ${borrow.returnDate ?? "Not returned"}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
