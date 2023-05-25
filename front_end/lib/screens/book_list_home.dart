import 'package:flutter/material.dart';
// import 'package:separated_row/separated_row.dart';

import '../models/books.dart';
import '../services/book/book_services.dart';

class BookListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<Book>>(
      future: BookService.fetchAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final books = snapshot.data ?? [];
          final limitedBooks = books.take(10).toList(); // Lấy chỉ 10 cuốn sách

          return ListView.builder(
            itemCount: limitedBooks.length,
            itemBuilder: (context, index) {
              final book = limitedBooks[index];
              return Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text('${book.id}')),
                          Expanded(child: Text(book.title)),
                          Expanded(child: Text('${book.author}')),
                          Expanded(child: Text('${book.quantity}'))
                        ],
                      ),
                    ),
                    Divider()
                  ],
                ),
              );
            },
          );
        }
      },
    ));
  }
}
