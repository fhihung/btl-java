import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/borrowers.dart';
import '../../services/borrower_service.dart';

class AddBorrowerScreen extends StatefulWidget {
  @override
  _AddBorrowerScreenState createState() => _AddBorrowerScreenState();
}

class _AddBorrowerScreenState extends State<AddBorrowerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _addBorrower(Borrower borrower) async {
    if (_formKey.currentState!.validate()) {
      final borrower = Borrower(
        fullName: _fullNameController.text,
        address: _addressController.text,
        phoneNumber: _phoneNumberController.text,
        email: _emailController.text,
      );

      try {
        await BorrowerService.add(borrower);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add book')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Borrower'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the borrower\'s full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the borrower\'s address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the borrower\'s phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the borrower\'s email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Borrower borrower = Borrower(
                      fullName: _fullNameController.text,
                      address: _addressController.text,
                      phoneNumber: _phoneNumberController.text,
                      email: _emailController.text,
                    );
                    _addBorrower(borrower);
                  }
                },
                child: Text('Add Borrower'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
