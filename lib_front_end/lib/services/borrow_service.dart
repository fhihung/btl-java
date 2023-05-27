import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/books.dart';
import '../models/borrowers.dart';
import '../models/borrows.dart';
import 'book_services.dart';
import 'borrower_service.dart';

class BorrowService {
  static const String baseUrl = 'http://localhost:9000/borrows';

  static Future<List<Borrow>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final borrows = data.map((item) => Borrow.fromJson(item)).toList();
      return borrows;
    } else {
      throw Exception('Failed to fetch borrow');
    }
  }

  static Future<List<Borrow>> fetchAllBorrow() async {
    try {
      List<Book> books = await BookService.fetchAll();
      List<Borrower> borrowers = await BorrowerService.fetchAll();
      List<Borrow> borrows = await BorrowService.fetchAll();

      for (Borrow borrow in borrows) {
        Book book = books.firstWhere((book) => book.id == borrow.bookId);
        Borrower borrower = borrowers
            .firstWhere((borrower) => borrower.id == borrow.borrowerId);

        borrow.bookName = book?.title ?? 'Unknown';
        borrow.borrowerName = borrower?.fullName ?? 'Unknown';
      }

      return borrows;
    } catch (e) {
      // Handle error
      print(e);
      return [];
    }
  }

  static Future<void> sendBorrowRequest(Borrow borrow) async {
    final url = Uri.parse('$baseUrl/addBorrow');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'book': {'id': borrow.bookId},
      'borrower': {'id': borrow.borrowerId},
      'borrowDate': borrow.borrowDate,
      'dueDate': borrow.dueDate,
      'returnDate': borrow.returnDate,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode != 200) {
      throw Exception('Failed to send borrow request');
    }
  }

  // static Future<void> sendReturnRequest(Borrow borrow) async {
  //   final url = Uri.parse('$baseUrl/returnBook');
  //   final headers = <String, String>{
  //     'Content-Type': 'application/json',
  //   };
  //   final body = jsonEncode({
  //     'book': {'id': borrow.bookId},
  //     'borrower': {'id': borrow.borrowerId},
  //     'borrowDate': borrow.borrowDate,
  //     'dueDate': borrow.dueDate,
  //     'returnDate': borrow.returnDate,
  //   });

  //   final response = await http.post(url, headers: headers, body: body);

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to send return request');
  //   }
  // }

  // Future<Borrow> returnBook(Borrow borrow) async {
  //   final response = await http.post(
  //     Uri.parse('http://your-api-url/returnBook'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(borrow.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     return Borrow.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to return book: ${response.statusCode}');
  //   }
  // }
  static Future<Borrow> returnBook(int borrowId) async {
    final url = Uri.parse('$baseUrl/returnBook');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'id': borrowId});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Borrow.fromJson(jsonData);
    } else {
      throw Exception('Failed to return book');
    }
  }
}
