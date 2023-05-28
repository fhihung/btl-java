import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../../services/borrow_service.dart';
import '../../widgets/constants.dart';

class BookScreen extends StatefulWidget {
  final int borrowerId;

  BookScreen({required this.borrowerId});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  Future<List<Book>> _fetchBooks() async {
    // Gọi service để lấy thông tin sách theo borrowerId
    return BorrowService.getBooksByBorrower(widget.borrowerId);
  }

  void _showBookDescriptionDialog(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Description'),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tài liệu đang mượn',
          style: TextStyle(color: primaryBlack),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: primaryBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('ID')),
                  Expanded(flex: 3, child: Text('Title')),
                  Expanded(flex: 2, child: Text('Author')),
                  Expanded(flex: 2, child: Text('Description')),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: _fetchBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final books = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(child: Text('${book.id}')),
                                    Expanded(flex: 3, child: Text(book.title)),
                                    Expanded(
                                        flex: 2, child: Text('${book.author}')),
                                    Expanded(
                                      flex: 2,
                                      child: Tooltip(
                                        message: book.description,
                                        child: GestureDetector(
                                          onTap: () {
                                            _showBookDescriptionDialog(
                                                context, book.description!);
                                          },
                                          child: Text(
                                            '${book.description}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      },
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
