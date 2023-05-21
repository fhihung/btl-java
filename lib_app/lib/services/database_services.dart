// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../models/books.dart';
// import 'globals.dart';

// class DatabaseService {
//   static Future<Book> addBook(
//     String title,
//     String author,
//     int quantity,
//     int borrowerId,
//     int borrowerQuantity,
//   ) async {
//     Map data = {
//       "title": title,
//       "author": author,
//       "quantity": quantity,
//       "borrowerId": borrowerId,
//       "borrowerQuantity": borrowerQuantity
//     };
//     var body = json.encode(data);
//     var url = Uri.parse(baseURL + '/add');
//     http.Response response = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );
//     print(response.body);
//     Map responseMap = jsonDecode(response.body);
//     Book book = Book.fromMap(responseMap);
//     return book;
//   }

//   static Future<List<Book>> getBooks() async {
//     var url = Uri.parse(baseURL);
//     http.Response response = await http.get(
//       url,
//       headers: headers,
//     );
//     print(response.body);
//     List responseList = jsonDecode(response.body);
//     List<Book> books = [];
//     for (Map bookMap in responseList) {
//       Book book = Book.fromMap(bookMap);
//       books.add(book);
//     }
//     return books;
//   }

//   static Future<http.Response> updateTask(int id) async {
//     var url = Uri.parse(baseURL + '/update/$id');
//     http.Response response = await http.put(url, headers: headers);
//     print(response.body);
//     return response;
//   }

//   static Future<http.Response> deleteTask(int id) async {
//     var url = Uri.parse(baseURL + '/delete/$id');
//     http.Response response = await http.delete(url, headers: headers);
//     print(response.body);
//     return response;
//   }
// }
