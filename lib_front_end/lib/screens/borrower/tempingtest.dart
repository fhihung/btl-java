import 'package:flutter/material.dart';

import '../../models/books.dart';
import '../../services/borrow_service.dart';

class BooksByBorrowerScreen extends StatefulWidget {
  @override
  _BooksByBorrowerScreenState createState() => _BooksByBorrowerScreenState();
}

class _BooksByBorrowerScreenState extends State<BooksByBorrowerScreen> {
  late int borrowerId;
  List<Book> books = [];

  void getBooks() async {
    try {
      final result = await BorrowService.getBooksByBorrower(borrowerId);
      setState(() {
        books = result;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Books by Borrower'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Borrower ID',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  borrowerId = int.tryParse(value)!;
                });
              },
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                getBooks();
              },
              child: Text('Get Books'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
