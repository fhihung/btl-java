// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:lib_app/widgets/home_appbar.dart';

import '../services/book_services.dart';
import '../services/borrower_service.dart';
import '../widgets/box_get_total.dart';
import '../widgets/constants.dart';

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
