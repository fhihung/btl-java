import 'package:flutter/material.dart';
import 'package:lib_app/widgets/constants.dart';
import 'package:lib_app/widgets/show_info_dialog.dart';

import '../models/books.dart';
import '../services/book/book_services.dart';

enum SearchOption {
  Title,
  Author,
  Publisher,
}

class BookSearchScreen extends StatefulWidget {
  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _searchResults = [];
  SearchOption _selectedOption = SearchOption.Title;

  Future<void> _searchBooks(String query) async {
    try {
      List<Book> results = [];
      if (_selectedOption == SearchOption.Title) {
        results = await BookService.searchByTitle(query);
      } else if (_selectedOption == SearchOption.Author) {
        results = await BookService.searchByAuthor(query);
      } else if (_selectedOption == SearchOption.Publisher) {
        results = await BookService.searchByPublisher(query);
      }
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Handle search error
    }
  }

  Future<void> _loadBooks() async {
    try {
      final books = await BookService.fetchAll();
      setState(() {
        _searchResults = books;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _deleteBook(int id) async {
    try {
      await BookService.delete(id);
      await _loadBooks();
    } catch (e) {
      // Handle delete error
    }
  }

  Future<void> _updateBook(Book book) async {
    try {
      await BookService.updateBook(book);
      await _loadBooks();
    } catch (e) {
      // Handle update error
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _showEditDialog(Book book) async {
    TextEditingController _titleController =
        TextEditingController(text: book.title);
    TextEditingController _authorController =
        TextEditingController(text: book.author);
    TextEditingController _publisherController =
        TextEditingController(text: book.publisher);
    TextEditingController _publicationYearController =
        TextEditingController(text: book.publicationYear.toString());
    TextEditingController _quantityController =
        TextEditingController(text: book.quantity.toString());
    TextEditingController _descriptionController =
        TextEditingController(text: book.description);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
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
                  labelText: 'PublicationYear',
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
              onPressed: () async {
                final updatedBook = Book(
                  id: book.id,
                  title: _titleController.text,
                  author: _authorController.text,
                  publisher: _publisherController.text,
                  publicationYear: int.parse(_publicationYearController.text),
                  quantity: int.parse(_quantityController.text),
                  description: _descriptionController.text,
                );
                await _updateBook(updatedBook);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            DropdownButton<SearchOption>(
              value: _selectedOption,
              onChanged: (SearchOption? option) {
                if (option != null) {
                  setState(() {
                    _selectedOption = option;
                  });
                }
              },
              items: [
                DropdownMenuItem(
                  value: SearchOption.Title,
                  child: Text('Search by Title'),
                ),
                DropdownMenuItem(
                  value: SearchOption.Author,
                  child: Text('Search by Author'),
                ),
                DropdownMenuItem(
                  value: SearchOption.Publisher,
                  child: Text('Search by Publisher'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: _selectedOption == SearchOption.Title
                    ? 'Title'
                    : _selectedOption == SearchOption.Author
                        ? 'Author'
                        : 'Publisher',
              ),
              onChanged: (value) {
                final query = _searchController.text;
                _searchBooks(query);
              },
            ),
            SizedBox(height: 16.0),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('ID')),
                  Expanded(child: Text('Tên')),
                  Expanded(child: Text('Tác giả')),
                  Expanded(child: Text('Số lượng')),
                  Expanded(child: Text('Khác')),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final book = _searchResults[index];
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text('${book.id}')),
                              Expanded(child: Text(book.title)),
                              Expanded(child: Text('${book.author}')),
                              Expanded(child: Text('${book.quantity}')),
                              Expanded(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        _showEditDialog(book);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteBook(book.id!);
                                      },
                                    ),
                                  ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
