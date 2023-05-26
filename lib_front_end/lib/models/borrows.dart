class Borrow {
  final int bookId;
  final int borrowerId;
  final String borrowDate;
  final String dueDate;
  String? returnDate;

  Borrow({
    required this.bookId,
    required this.borrowerId,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
  });

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
