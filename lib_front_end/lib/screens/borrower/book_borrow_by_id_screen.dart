import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../../services/borrow_service.dart';

class BookScreen extends StatefulWidget {
  final int borrowerId;

  BookScreen({required this.borrowerId});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Future<List<Book>> _fetchBooks() async {
    // Gọi service để lấy thông tin sách theo borrowerId
    return BorrowService.getBooksByBorrower(widget.borrowerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books Borrowed'),
      ),
      body: FutureBuilder<List<Book>>(
        future: _fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final books = snapshot.data ?? [];

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author ?? ''),
                );
              },
            );
          }
        },
      ),
    );
  }
}
