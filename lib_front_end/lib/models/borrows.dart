// ignore_for_file: public_member_api_docs, sort_constructors_first
class Borrow {
  int? id;
  final int bookId;
  final int borrowerId;
  final String borrowDate;
  final String dueDate;
  String? returnDate;

  Borrow({
    this.id,
    required this.bookId,
    required this.borrowerId,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
  });

  factory Borrow.fromJson(Map<String, dynamic> json) {
    return Borrow(
      bookId: json['bookId'],
      borrowerId: json['borrowerId'],
      borrowDate: json['borrowDate'],
      dueDate: json['dueDate'],
      returnDate: json['returnDate'],
    );
  }
    factory Borrow.fromJson(Map<String, dynamic> json) {
    return Borrow(
      id: json['id'],
      borrowDate: json['borrowDate'],
      dueDate: json['dueDate'],
      returnDate: json['returnDate'],
    );
  }
}

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'borrowerId': borrowerId,
      'borrowDate': borrowDate,
      'dueDate': dueDate,
      'returnDate': returnDate,
    };
  }
}
