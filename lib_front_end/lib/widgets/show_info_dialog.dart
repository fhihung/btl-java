import 'package:flutter/material.dart';

import '../models/books.dart';

class showInformDialog extends StatelessWidget {
  const showInformDialog({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Tên tài liệu'),
            subtitle: Text(book.title),
          ),
          ListTile(
            title: Text('Tác giả'),
            subtitle: Text(book.author!),
          ),
          ListTile(
            title: Text('Nhà xuất bản'),
            subtitle: Text(book.publisher!),
          ),
          ListTile(
            title: Text('Năm phát hành'),
            subtitle: Text('${book.publicationYear}'),
          ),
          ListTile(
            title: Text('Số lượng'),
            subtitle: Text('${book.quantity}'),
          ),
          ListTile(
            title: Text('Mô tả'),
            subtitle: Text('${book.description}'),
          )
        ],
      ),
      actions: [
        TextButton(
          child: Text('Exit'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
