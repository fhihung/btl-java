import 'package:flutter/material.dart';

import '../models/books.dart';
import '../models/borrowers.dart';
import '../services/borrower_service.dart';

class BorrowerListWidgett extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // ...
      child: FutureBuilder<List<Borrower>>(
        future: BorrowerService.fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final borrowers = snapshot.data ?? [];

            return ListView.builder(
              itemCount: borrowers.length,
              itemBuilder: (context, index) {
                final borrower = borrowers[index];

                // Hiển thị thông tin người mượn
                return Column(
                  children: [
                    // ... Hiển thị thông tin người mượn ...

                    // Hiển thị danh sách sách mà người mượn mượn
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: borrower.borrowedBooks?.length ?? 0,
                      itemBuilder: (context, bookIndex) {
                        final borrowedBook = borrower.borrowedBooks![bookIndex];

                        // Hiển thị thông tin sách mượn
                        return ListTile(
                          title: Text(borrowedBook.title),
                          subtitle: Text(borrowedBook.author ?? ''),
                          // ... Hiển thị các thông tin khác về sách mượn ...
                        );
                      },
                    ),

                    // ...
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
