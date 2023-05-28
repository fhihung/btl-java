import 'package:flutter/material.dart';
import 'package:lib_app/screens/borrower/add_borrower_screen.dart';

import '../../models/books.dart';
import '../../models/borrowers.dart';
import '../../services/borrow_service.dart';
import '../../services/borrower_service.dart';
import '../../widgets/constants.dart';
import 'search_borrower_screen.dart';

class BorrowerListWidget extends StatefulWidget {
  @override
  State<BorrowerListWidget> createState() => _BorrowerListWidgetState();
}

class _BorrowerListWidgetState extends State<BorrowerListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        flex: 3,
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
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(left: 5, bottom: 10),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.all(5),
                              side: BorderSide(color: primaryBlack),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddBorrowerScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Add New Borrower',
                              style: TextStyle(color: primaryBlack),
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
                      Expanded(
                        flex: 1,
                        child: Text('ID'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Name'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Address'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Phone'),
                      ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Text('Email'),
                      // ),
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
                                return SearchBorrowerScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Xem chi tiết',
                          style: TextStyle(color: primaryBlack),
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
