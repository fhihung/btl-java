// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Book {
//   final int id;
//   final String title;
//   final String author;
//   final String publisher;
//   final int publicationYear;
//   final int quantity;
//   final String description;

//   Book({
//     required this.id,
//     required this.title,
//     required this.author,
//     required this.publisher,
//     required this.publicationYear,
//     required this.quantity,
//     required this.description,
//   });

//   factory Book.fromJson(Map<String, dynamic> json) {
//     return Book(
//       id: json['id'],
//       title: json['title'],
//       author: json['author'],
//       publisher: json['publisher'],
//       publicationYear: json['publicationYear'],
//       quantity: json['quantity'],
//       description: json['description'],
//     );
//   }
// }

// class BookListScreen extends StatefulWidget {
//   @override
//   _BookListScreenState createState() => _BookListScreenState();
// }

// class _BookListScreenState extends State<BookListScreen> {
//   List<Book> _books = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadBooks();
//   }

//   Future<void> _loadBooks() async {
//     final response = await http.get(Uri.parse('http://localhost:9000/books'));
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as List;
//       final books = data.map((item) => Book.fromJson(item)).toList();
//       setState(() {
//         _books = books;
//       });
//     } else {
//       // Handle error
//     }
//   }

//   Future<void> _addBook(Book book) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:9000/books/add'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'id': book.id,
//         'title': book.title,
//         'author': book.author,
//         'publisher': book.publisher,
//         'publicationYear': book.publicationYear,
//         'quantity': book.quantity,
//         'description': book.description,
//       }),
//     );
//     if (response.statusCode == 201) {
//       _loadBooks();
//     } else {
//       // Handle error
//     }
//   }

//   Future<void> _updateBookQuantity(int id, int newQuantity) async {
//     final response = await http.put(
//       Uri.parse('http://localhost:9000/books/$id/quantity'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'quantity': newQuantity,
//       }),
//     );
//     if (response.statusCode == 204) {
//       _loadBooks();
//     } else {
//       // Handle error
//     }
//   }
//   Future<void> _deleteBook(int id) async {
// final response = await http.delete(Uri.parse('http://localhost:9000/books/$id'));
// if (response.statusCode == 204) {
// _loadBooks();
// } else {
// // Handle error
// }
// }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw Scaffold(
// appBar: AppBar(
// title: Text('Book List'),
// ),
// body: ListView.builder(
// itemCount: _books.length,
// itemBuilder: (context, index) {
// final book = _books[index];
// return ListTile(
// title: Text(book.title),
// subtitle: Text(book.author),
// trailing: Text('Quantity: ${book.quantity}'),
// onTap: () async {
// final newQuantity = await showDialog<int>(
// context: context,
// builder: (context) => QuantityDialog(
// initialQuantity: book.quantity,
// ),
// );
// if (newQuantity != null) {
// await _updateBookQuantity(book.id, newQuantity);
// }
// },
// onLongPress: () {
// showDialog(
// context: context,
// builder: (context) => AlertDialog(
// title: Text('Delete Book'),
// content: Text('Are you sure you want to delete this book?'),
// actions: <Widget>[
// TextButton(
// child: Text('Cancel'),
// onPressed: () => Navigator.of(context).pop(),
// ),
// TextButton(
// child: Text('Delete'),
// onPressed: () async {
// await _deleteBook(book.id);
// Navigator.of(context).pop();
// },
// ),
// ],
// ),
// );
// },
// );
// },
// ),
// floatingActionButton: FloatingActionButton(
// child: Icon(Icons.add),
// onPressed: () async {
// final book = await showDialog<Book>(
// context: context,
// builder: (context) => AddBookDialog(),
// );
// if (book != null) {
// await _addBook(book);
// }
// },
// ),
// );
// }
// }

// class AddBookDialog extends StatefulWidget {
// @override
// _AddBookDialogState createState() => _AddBookDialogState();
// }

// class _AddBookDialogState extends State<AddBookDialog> {
// final _formKey = GlobalKey<FormState>();
// late int _id;
// late String _title;
// late String _author;
// late String _publisher;
// late int _publicationYear;
// late int _quantity;
// late String _description;

// @override
// Widget build(BuildContext context) {
// return AlertDialog(
// title: Text('Add Book'),
// content: Form(
// key: _formKey,
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: <Widget>[
// TextFormField(
// decoration: InputDecoration(
// labelText: 'ID',
// ),
// keyboardType: TextInputType.number,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter an ID';
// }
// return null;
// },
// onSaved: (value) {
// _id = int.parse(value!);
// },
// ),
// TextFormField(
// decoration: InputDecoration(
// labelText: 'Title',
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter a title';
// }
// return null;
// },
// onSaved: (value) {
// _title = value!;
// },
// ),
// TextFormField(
// decoration: labelText: 'Author',
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter an author';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _author = value!;
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Publisher',
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a publisher';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _publisher = value!;
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Publication Year',
//           ),
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a publication year';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _publicationYear = int.parse(value!);
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Quantity',
//           ),
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a quantity';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _quantity = int.parse(value!);
//           },
//         ),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Description',
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a description';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _description = value!;
//           },
//         ),
//       ],
//     ),
//   ),
//   actions: <Widget>[
//     TextButton(
//       child: Text('Cancel'),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     ),
//     TextButton(
//       child: Text('Add'),
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           _formKey.currentState!.save();
//           final book = Book(
//             id: _id,
//             title: _title,
//             author: _author,
//             publisher: _publisher,
//             publicationYear: _publicationYear,
//             quantity: _quantity,
//             description: _description,
//           );
//           Navigator.of(context).pop(book);
//         }
//       },
//     ),
//   ],
// );
// }
// }

// class QuantityDialog extends StatefulWidget {
// final int initialQuantity;

// QuantityDialog({required this.initialQuantity});

// @override
// _QuantityDialogState createState() => _QuantityDialogState();
// }

// class _QuantityDialogState extends State<QuantityDialog> {
// late int _quantity;

// @override
// void initState() {
// super.initState();
// _quantity = widget.initialQuantity;
// }

// @override
// Widget build(BuildContext context) {
// return AlertDialog(
// title: Text('Update Quantity'),
// content: Column(
// mainAxisSize: MainAxisSize.min,
// children: <Widget>[
// Text('Current Quantity: ${widget.initialQuantity}'),
// TextFormField(
// decoration: InputDecoration(
// labelText: 'New Quantity',
// ),
// keyboardType: TextInputType.number,
// initialValue: widget.initialQuantity.toString(),
// onChanged: (value) {
// _quantity = int.parse(value);
// },
// ),
// ],
// ),
// actions: <Widget>[
// TextButton(
// child: Text('Cancel'),
// onPressed: () {
// Navigator.of(context).pop();
// },
// ),
// TextButton(
// child: Text('Update'),
// onPressed: () {
// Navigator.of(context).pop(_quantity);
// },
// ),
// ],
// );
// }
// }
//   }





