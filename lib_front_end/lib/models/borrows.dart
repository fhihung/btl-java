// ignore_for_file: public_member_api_docs, sort_constructors_first
class Borrow {
  int? id;
  final int bookId;
  final int borrowerId;
  final String borrowDate;
  final String dueDate;
  final String? returnDate;
  String? bookName;
  String? borrowerName;

  Borrow({
    this.id,
    required this.bookId,
    required this.borrowerId,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
    this.bookName,
    this.borrowerName,
  });

  factory Borrow.fromJson(Map<String, dynamic> json) {
    return Borrow(
      id: json['borrowId'],
      bookId: json['bookId'],
      borrowerId: json['borrowerId'],
      borrowDate: json['borrowDate'],
      dueDate: json['dueDate'],
      returnDate: json['returnDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book': {'id': bookId},
      'borrower': {'id': borrowerId},
      'borrowDate': borrowDate,
      'dueDate': dueDate,
      'returnDate': returnDate,
    };
  }
}
