import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/borrowers.dart';
import '../../services/borrower_service.dart';
import '../../widgets/constants.dart';

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
        backgroundColor: white,
        title: Text(
          'Add Borrower',
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
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: primaryBlack,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the borrower\'s full name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: primaryBlack,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the borrower\'s address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: primaryBlack,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the borrower\'s phone number';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: primaryBlack,
                        width: 2.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the borrower\'s email';
                    }
                    return null;
                  },
                ),
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
