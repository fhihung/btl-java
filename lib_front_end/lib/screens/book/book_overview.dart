import 'package:flutter/material.dart';

import '../../widgets/constants.dart';
import 'book_list_home.dart';

class BookInOverview extends StatelessWidget {
  const BookInOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ), // Màu nền của box
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, bottom: 10),
                      child: Text(
                        'Books List',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, bottom: 10),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(5),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () {},
                        child: Text(
                          'Add New Book',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('ID')),
                  Expanded(child: Text('Tên')),
                  Expanded(child: Text('Tác giả')),
                  Expanded(child: Text('Số lượng')),
                  Expanded(child: Text('Khác')),
                ],
              ),
            ),
            Divider(),
            Expanded(child: BookListWidget()),
          ],
        ),
      ),
    );
  }
}
