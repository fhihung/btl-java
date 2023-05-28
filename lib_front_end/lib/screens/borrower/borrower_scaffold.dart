import 'package:flutter/material.dart';
import 'package:lib_app/screens/borrower/add_borrower_screen.dart';

import '../../models/books.dart';
import '../../models/borrowers.dart';
import '../../services/borrow_service.dart';
import '../../services/borrower_service.dart';
import '../../widgets/constants.dart';
import 'book_borrow_by_id_screen.dart';

class BorrowerListScreen extends StatefulWidget {
  @override
  State<BorrowerListScreen> createState() => _BorrowerListScreenState();
}

class _BorrowerListScreenState extends State<BorrowerListScreen> {
  List<List<Book>> booksByBorrower = [];

  @override
  void initState() {
    super.initState();
    _fetchBooksByBorrower();
  }

  Future<void> _fetchBooksByBorrower() async {
    final borrowers = await BorrowerService.fetchAll();
    final List<Future<List<Book>>> bookFutures = borrowers
        .map((borrower) => BorrowService.getBooksByBorrower(borrower.id!))
        .toList();

    final List<List<Book>> booksList = await Future.wait(bookFutures);

    setState(() {
      booksByBorrower = booksList;
    });
  }

  void _showBooksScreen(int borrowerId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookScreen(borrowerId: borrowerId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: FutureBuilder<List<Borrower>>(
          future: BorrowerService.fetchAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final borrowers = snapshot.data ?? [];

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
                              'Borrowers List',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     margin: EdgeInsets.only(left: 5, bottom: 10),
                        //     child: OutlinedButton(
                        //       style: OutlinedButton.styleFrom(
                        //         padding: EdgeInsets.all(5),
                        //         side: BorderSide(color: Colors.black),
                        //       ),
                        //       onPressed: () {
                        //         // Navigate to AddBorrowerScreen
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   AddBorrowerScreen()),
                        //         );
                        //       },
                        //       child: Text(
                        //         'Add New Borrower',
                        //         style: TextStyle(color: Colors.black),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text('ID'),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Tên'),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Địa chỉ'),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('SĐT'),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Email'),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Khác'),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: borrowers.length,
                      itemBuilder: (context, index) {
                        final borrower = borrowers[index];

                        return Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Tooltip(
                                  message: borrower.id.toString(),
                                  child: Text(
                                    borrower.id.toString(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Tooltip(
                                  message: borrower.fullName,
                                  child: Text(
                                    borrower.fullName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Tooltip(
                                  message: borrower.address,
                                  child: Text(
                                    '${borrower.address}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Tooltip(
                                  message: borrower.phoneNumber,
                                  child: Text(
                                    '${borrower.phoneNumber}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Tooltip(
                                  message: borrower.email,
                                  child: Text(
                                    '${borrower.email}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: PopupMenuButton(
                                  icon: Icon(Icons.more_horiz),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem<int>(
                                          value: 0,
                                          child: Text("Sách đang mượn")),
                                      // PopupMenuItem<int>(
                                      //   value: 1,
                                      //   child: Text("Sửa"),
                                      // ),
                                      // PopupMenuItem<int>(
                                      //   value: 2,
                                      //   child: Text("Xóa"),
                                      // ),
                                    ];
                                  },
                                  onSelected: (value) {
                                    if (value == 0) {
                                      _showBooksScreen(borrower.id!);
                                    }
                                  },

                                  // _showEditDialog(book);
                                ),
                                //  GestureDetector(
                                //   onTap: () {
                                //     _showBooksScreen(borrower.id!);
                                //   },
                                //   child: Icon(Icons.more_horiz),
                                // ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
