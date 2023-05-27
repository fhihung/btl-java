import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lib_app/screens/book/add_book_screen.dart';
import 'package:lib_app/screens/borrow/request_borrow_screen.dart';

import 'package:lib_app/services/book_services.dart';

import 'package:lib_app/widgets/constants.dart';

import '../../models/borrows.dart';
import '../../services/borrow_service.dart';

class BorrowListWidget extends StatefulWidget {
  @override
  State<BorrowListWidget> createState() => _BorrowListWidgetState();
}

class _BorrowListWidgetState extends State<BorrowListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder<List<Borrow>>(
        future: BorrowService.fetchAllBorrow(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final borrows = snapshot.data ?? [];

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
                            'Borrow List',
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
                                    return BorrowRequestScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Add New Borrow',
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
                      Expanded(flex: 2, child: Text('Tên Sách')),
                      Expanded(flex: 2, child: Text('Người mượn')),
                      Expanded(flex: 2, child: Text('Ngày mượn')),
                      Expanded(flex: 2, child: Text('Hạn trả')),
                      Expanded(flex: 2, child: Text('Ngày trả')),
                      Expanded(flex: 2, child: Text('More')),
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: borrows.length,
                    itemBuilder: (context, index) {
                      final borrow = borrows[index];
                      final borrowDate = DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(borrow.borrowDate));
                      final dueDate = DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(borrow.dueDate));
                      final returnDate = borrow.returnDate != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(borrow.returnDate!))
                          : 'Chưa trả';
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Tooltip(
                                        message: '${borrow.id}',
                                        child: Text(
                                          '${borrow.id}',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Tooltip(
                                        message: borrow.bookName,
                                        child: Text(
                                          '${borrow.bookName}',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Tooltip(
                                        message: borrow.borrowerName,
                                        child: Text(
                                          '${borrow.borrowerName}',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Tooltip(
                                        message: borrowDate,
                                        child: Text(
                                          '${borrowDate}',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Tooltip(
                                        message: dueDate,
                                        child: Text(
                                          '${dueDate}',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Tooltip(
                                        message: returnDate,
                                        child: Text(
                                          '${returnDate}',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      PopupMenuButton(
                                        icon: Icon(Icons.more_horiz),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: Text('Return Book'),
                                              onTap: () {
                                                setState(() {
                                                  BorrowService.returnBook(
                                                      borrow.id!);
                                                });
                                              },
                                            ),
                                          ];
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
