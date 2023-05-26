import 'package:flutter/material.dart';

import '../models/books.dart';
import '../services/book/book_services.dart';

class EditDialog extends StatefulWidget {
  final Book book;

  const EditDialog({required this.book});

  @override
  _EditDialogState createState() => _EditDialogState();
}

Future<void> _updateBook(Book book) async {
  try {
    await BookService.updateBook(book);
  } catch (e) {
    // Handle update error
  }
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _publisherController;
  late TextEditingController _publicationYearController;
  late TextEditingController _quantityController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _publisherController = TextEditingController(text: widget.book.publisher);
    _publicationYearController =
        TextEditingController(text: widget.book.publicationYear.toString());
    _quantityController =
        TextEditingController(text: widget.book.quantity.toString());
    _descriptionController =
        TextEditingController(text: widget.book.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _publicationYearController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final updatedBook = Book(
      id: widget.book.id,
      title: _titleController.text,
      author: _authorController.text,
      publisher: _publisherController.text,
      publicationYear: int.parse(_publicationYearController.text),
      quantity: int.parse(_quantityController.text),
      description: _descriptionController.text,
    );
    await _updateBook(updatedBook);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Book'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _authorController,
            decoration: InputDecoration(
              labelText: 'Author',
            ),
          ),
          TextField(
            controller: _publisherController,
            decoration: InputDecoration(
              labelText: 'Publisher',
            ),
          ),
          TextField(
            controller: _publicationYearController,
            decoration: InputDecoration(
              labelText: 'Publication Year',
            ),
          ),
          TextField(
            controller: _quantityController,
            decoration: InputDecoration(
              labelText: 'Quantity',
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Save'),
          onPressed: _saveChanges,
        ),
      ],
    );
  }
}
