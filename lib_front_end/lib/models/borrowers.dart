import 'books.dart';

class Borrower {
  int? id;
  String fullName;
  String? address;
  String? phoneNumber;
  String? email;
  List<Book>? borrowedBooks; // Danh sách sách mượn

  Borrower({
    this.id,
    required this.fullName,
    this.address,
    this.phoneNumber,
    this.email,
    this.borrowedBooks,
  });

  factory Borrower.fromJson(Map<String, dynamic> json) {
    return Borrower(
      id: json['id'],
      fullName: json['fullName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}