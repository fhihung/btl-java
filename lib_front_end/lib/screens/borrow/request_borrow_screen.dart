import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/books.dart';
import '../../models/borrows.dart';
import '../../services/book_services.dart';
import '../../services/borrow_service.dart';

class BorrowRequestScreen extends StatefulWidget {
  @override
  _BorrowRequestScreenState createState() => _BorrowRequestScreenState();
}

class _BorrowRequestScreenState extends State<BorrowRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _borrowerIdController = TextEditingController();
  final _borrowDateController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _returnDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _borrowerIdController.dispose();
    _borrowDateController.dispose();
    _dueDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  void _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      final selectedBook = _titleController.text;
      final books = await _loadBooks();
      final book = books.firstWhere((book) => book.title == selectedBook);

      final borrow = Borrow(
        bookId: book.id!,
        borrowerId: int.parse(_borrowerIdController.text),
        borrowDate: _borrowDateController.text,
        dueDate: _dueDateController.text,
        returnDate: _returnDateController.text,
      );

      try {
        await BorrowService.sendBorrowRequest(borrow);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Borrow request sent successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send borrow request')),
        );
      }
    }
  }

  Future<void> _selectBorrowDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _borrowDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _returnDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrow Request'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Book Title'),
                ),
                suggestionsCallback: (pattern) async {
                  final List<Book> books = await _loadBooks();
                  final List<String> titles = books
                      .where((book) => book.title
                          .toLowerCase()
                          .contains(pattern.toLowerCase()))
                      .map((book) => '${book.id} - ${book.title}')
                      .toList();
                  return titles;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      suggestion,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _titleController.text = suggestion.split(' - ')[1];
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the book title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _borrowerIdController,
                decoration: InputDecoration(labelText: 'Borrower ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the borrower ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _borrowDateController,
                decoration: InputDecoration(
                  labelText: 'Borrow Date',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectBorrowDate(context);
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select the borrow date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dueDateController,
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectDueDate(context);
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select the due date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _returnDateController,
                decoration: InputDecoration(
                  labelText: 'Return Date',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectReturnDate(context);
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
                readOnly: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitRequest,
                child: Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Book>> _loadBooks() async {
    // Replace this with your own function to fetch the list of books
    final books = await BookService.fetchAll();
    return books;
  }
}
