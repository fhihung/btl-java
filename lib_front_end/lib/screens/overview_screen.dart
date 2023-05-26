// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:lib_app/widgets/home_appbar.dart';

import '../services/book_services.dart';
import '../services/borrower_service.dart';
import '../widgets/box_get_total.dart';
import '../widgets/constants.dart';
import 'book/book_list_home.dart';
import 'book/book_list_screen.dart';
import 'borrower/borrower_list_screen.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                GetTotalContainer(
                  icon: Icon(Icons.people),
                  text: 'Người mượn',
                  service: BorrowerService.fetchTotalBorrowerCount(),
                ),
                GetTotalContainer(
                  icon: Icon(Icons.book),
                  text: 'Số sách',
                  service: BookService.fetchTotalBookCount(),
                ),
              ],
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth < 600) {
                    // Nếu màn hình thu nhỏ, hiển thị BookListWidget và BorrowerWidget trong một cột
                    return Column(
                      children: [
                        Expanded(child: BookListWidget()),
                        Expanded(child: BorrowerListWidget()),
                      ],
                    );
                  } else {
                    // Nếu màn hình đủ rộng, hiển thị BookListWidget và BorrowerWidget trong hai cột song song
                    return Row(
                      children: [
                        Expanded(child: BookListWidget()),
                        Expanded(child: BorrowerListWidget()),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookInOverview extends StatelessWidget {
  const BookInOverview({Key? key});

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
                      onPressed: () {},
                      child: Text(
                        'Add New Book',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
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
              child: BookListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class BorrowerInOverView extends StatelessWidget {
  const BorrowerInOverView({Key? key});

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
                      onPressed: () {},
                      child: Text(
                        'Add New Book',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
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
            Expanded(
              child: BorrowerListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
