import 'package:flutter/material.dart';

import '../../widgets/constants.dart';
import 'borrower_list_screen.dart';

class BorrowerInOverView extends StatelessWidget {
  const BorrowerInOverView({
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
                  Expanded(flex: 1, child: Text('ID')),
                  Expanded(flex: 2, child: Text('Tên')),
                  Expanded(flex: 2, child: Text('Địa chỉ')),
                  Expanded(flex: 2, child: Text('SĐT')),
                  Expanded(flex: 2, child: Text('Email')),
                  Expanded(flex: 2, child: Text('Khác')),
                ],
              ),
            ),
            Divider(),
            Expanded(child: BorrowerListWidget()),
          ],
        ),
      ),
    );
  }
}
