import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/borrows.dart';

class BorrowService {
  static const String baseUrl = 'http://localhost:9000/borrows';

  static Future<List<Borrow>> fetchAllBorrow() async {
    final response = await http.get(Uri.parse('$baseUrl/getBorrowInfo'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final borrows = data.map((item) => Borrow.fromJson(item)).toList();
      return borrows;
    } else {
      throw Exception('Failed to fetch borrow');
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

  static Future<void> sendReturnRequest(Borrow borrow) async {
    final url = Uri.parse('$baseUrl/returnBook');
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
      throw Exception('Failed to send return request');
    }
  }
  Future<Borrow> returnBook(Borrow borrow) async {
  final response = await http.post(
    Uri.parse('http://your-api-url/returnBook'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(borrow.toJson()),
  );

  if (response.statusCode == 200) {
    return Borrow.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to return book: ${response.statusCode}');
  }
}
}
