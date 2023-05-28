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

  static Future<List<Borrower>> searchByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/search/name/$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final borrowers = data.map((item) => Borrower.fromJson(item)).toList();
      return borrowers;
    } else {
      throw Exception('Failed to search borrowers by name');
    }
  }

  static Future<List<Borrower>> searchByAddress(String address) async {
    final response =
        await http.get(Uri.parse('$baseUrl/search/address/$address'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final borrowers = data.map((item) => Borrower.fromJson(item)).toList();
      return borrowers;
    } else {
      throw Exception('Failed to search borrowers by address');
    }
  }

  static Future<List<Borrower>> searchByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/search/email/$email'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final borrowers = data.map((item) => Borrower.fromJson(item)).toList();
      return borrowers;
    } else {
      throw Exception('Failed to search borrowers by email');
    }
  }

  static Future<List<Borrower>> searchByPhone(String phone) async {
    final response = await http.get(Uri.parse('$baseUrl/search/phone/$phone'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final borrowers = data.map((item) => Borrower.fromJson(item)).toList();
      return borrowers;
    } else {
      throw Exception('Failed to search borrowers by phone');
    }
  }

  static Future<Borrower> updateBorrower(Borrower borrower) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/${borrower.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(borrower.toJsonWithoutId()),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Borrower.fromJson(data);
    } else {
      throw Exception('Failed to update borrower');
    }
  }

  static Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete borrower');
    }
  }
}
