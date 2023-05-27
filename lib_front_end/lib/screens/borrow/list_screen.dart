import 'package:flutter/material.dart';

import '../../models/borrows.dart';
import '../../services/borrow_service.dart';

class BorrowScreen extends StatefulWidget {
  @override
  _BorrowScreenState createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  List<Borrow> _borrowList = [];

  @override
  void initState() {
    super.initState();
    fetchBorrowData();
  }

  Future<void> fetchBorrowData() async {
    try {
      List<Borrow> borrows = await BorrowService.fetchAllBorrow();
      setState(() {
        _borrowList = borrows;
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrow List'),
      ),
      body: ListView.builder(
        itemCount: _borrowList.length,
        itemBuilder: (context, index) {
          Borrow borrow = _borrowList[index];
          return ListTile(
            title: Text('Borrow ID: ${borrow.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Book ID: ${borrow.bookId}'),
                Text('Borrower ID: ${borrow.borrowerId}'),
                Text('Borrow Date: ${borrow.borrowDate}'),
                Text('Due Date: ${borrow.dueDate}'),
                Text('Return Date: ${borrow.returnDate ?? 'Not returned yet'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
