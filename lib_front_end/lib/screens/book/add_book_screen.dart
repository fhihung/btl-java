// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/books.dart';
import '../../services/book_services.dart';
import '../../widgets/constants.dart';
import '../../widgets/rounded_textfield.dart';

class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _publisherController = TextEditingController();
  final _publicationYearController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      final book = Book(
        title: _titleController.text,
        author: _authorController.text,
        publisher: _publisherController.text,
        quantity: int.parse(_quantityController.text),
        description: _descriptionController.text,
      );

      try {
        await BookService.add(book);
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
        backgroundColor: white,
        title: Text(
          'Add Book',
          style: TextStyle(color: primaryBlack),
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
              RoundedTextFormFieldCon(
                  controller: _titleController,
                  hintText: 'Title',
                  keyboardType: TextInputType.text),
              RoundedTextFormFieldCon(
                  controller: _authorController,
                  hintText: 'Author',
                  keyboardType: TextInputType.name),
              RoundedTextFormFieldCon(
                  controller: _publisherController,
                  hintText: 'Publisher',
                  keyboardType: TextInputType.text),
              RoundedTextFormField(
                  controller: _publicationYearController,
                  hintText: 'Publication Year',
                  keyboardType: TextInputType.number),
              RoundedTextFormFieldCon(
                  controller: _quantityController,
                  hintText: 'Quantity',
                  keyboardType: TextInputType.number),
              RoundedTextFormField(
                controller: _descriptionController,
                hintText: 'Description',
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Add Book'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addBook();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
