import 'package:flutter/material.dart';

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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              controller: _titleController,
              decoration: InputDecoration(
                labelText: _selectedOption == SearchOption.Title
                    ? 'Title'
                    : _selectedOption == SearchOption.Author
                        ? 'Author'
                        : 'Publisher',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final query = _titleController.text;
                _searchBooks(query);
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final book = _searchResults[index];
                  return ListTile(
                    title: Text(book.title),
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
