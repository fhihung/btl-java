import 'package:flutter/material.dart';
import 'package:lib_app/screens/book/add_book_screen.dart';
import 'package:lib_app/screens/book/search_book_screen.dart';

// import 'package:separated_row/separated_row.dart';

import '../../models/books.dart';
import '../../services/book_services.dart';
import '../../widgets/constants.dart';

class BookListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<List<Book>>(
        future: BookService.fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final books = snapshot.data ?? [];
            // final limitedBooks =
            //     books.take(10).toList(); // Lấy chỉ 10 cuốn sách

            return Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(left: 5, bottom: 10),
                          child: Text(
                            'Books List',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 5, bottom: 10),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.all(5),
                              side: BorderSide(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddBookScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Add New Book',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 1, child: Text('ID')),
                      Expanded(flex: 2, child: Text('Tên')),
                      Expanded(flex: 2, child: Text('Tác giả')),
                      Expanded(flex: 2, child: Text('Số lượng')),
                      Expanded(flex: 2, child: Text('Khác')),
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Text('${book.id}')),
                            Expanded(flex: 2, child: Text(book.title)),
                            Expanded(flex: 2, child: Text('${book.author}')),
                            Expanded(flex: 2, child: Text('${book.quantity}')),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, bottom: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BookSearchScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Xem chi tiết',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
