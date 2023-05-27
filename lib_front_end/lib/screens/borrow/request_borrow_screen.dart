import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/borrows.dart';
import '../../services/borrow_service.dart';

class BorrowRequestScreen extends StatefulWidget {
  @override
  _BorrowRequestScreenState createState() => _BorrowRequestScreenState();
}

class _BorrowRequestScreenState extends State<BorrowRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bookIdController = TextEditingController();
  final _borrowerIdController = TextEditingController();
  final _borrowDateController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _returnDateController = TextEditingController();

  @override
  void dispose() {
    _bookIdController.dispose();
    _borrowerIdController.dispose();
    _borrowDateController.dispose();
    _dueDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  void _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      final borrow = Borrow(
        bookId: int.parse(_bookIdController.text),
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
              TextFormField(
                controller: _bookIdController,
                decoration: InputDecoration(labelText: 'Book ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the book ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _borrowerIdController,
                decoration: InputDecoration(labelText: 'Borrower ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the borrower ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _borrowDateController,
                decoration: InputDecoration(labelText: 'Borrow Date'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the borrow date';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () => _selectBorrowDate(context),
              ),
              TextFormField(
                controller: _dueDateController,
                decoration: InputDecoration(labelText: 'Due Date'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the due date';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () => _selectDueDate(context),
              ),
              TextFormField(
                controller: _returnDateController,
                decoration: InputDecoration(labelText: 'Return Date'),
                readOnly: true,
                onTap: () => _selectReturnDate(context),
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
}
