import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/borrowers.dart';

class BorrowerService {
  static const String baseUrl = 'http://localhost:9000/borrowers';

  static Future<void> add(Borrower borrower) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(borrower.toJsonWithoutId()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add book');
    }
  }

  static Future<int> fetchTotalBorrowerCount() async {
    final response = await http.get(Uri.parse('$baseUrl/count'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final int count = data;
      return count;
    } else {
      throw Exception('Failed to fetch borrower count');
    }
  }

  static Future<List<Borrower>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final borrowers = data.map((item) => Borrower.fromJson(item)).toList();
      return borrowers;
    } else {
      throw Exception('Failed to fetch borrower');
    }
  }
}
