import 'package:flutter/material.dart';
import 'package:lib_app/screens/borrower/add_borrower_screen.dart';

import '../../models/books.dart';
import '../../models/borrowers.dart';
import '../../services/borrow_service.dart';
import '../../services/borrower_service.dart';
import '../../widgets/constants.dart';
import '../../widgets/rounded_textfield.dart';
import 'book_borrow_by_id_screen.dart';

enum SearchOption { Name, Address, Phone, Email }

class SearchBorrowerNoScreen extends StatefulWidget {
  @override
  State<SearchBorrowerNoScreen> createState() => _SearchBorrowerNoScreenState();
}

class _SearchBorrowerNoScreenState extends State<SearchBorrowerNoScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Borrower> _searchResults = [];
  List<List<Book>> booksByBorrower = [];
  SearchOption _selectedOption = SearchOption.Name;
  Future<void> _searchBorrowers(String query) async {
    try {
      List<Borrower> results = [];
      if (_selectedOption == SearchOption.Name) {
        results = await BorrowerService.searchByName(query);
      } else if (_selectedOption == SearchOption.Address) {
        results = await BorrowerService.searchByAddress(query);
      } else if (_selectedOption == SearchOption.Phone) {
        results = await BorrowerService.searchByPhone(query);
      } else if (_selectedOption == SearchOption.Email) {
        results = await BorrowerService.searchByEmail(query);
      }
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Handle search error
    }
  }

  Future<void> _loadBorrower() async {
    try {
      final borrowers = await BorrowerService.fetchAll();
      setState(() {
        _searchResults = borrowers;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _deleteBorrower(int id) async {
    try {
      await BorrowerService.delete(id);
      await _loadBorrower();
    } catch (e) {
      // Handle delete error
    }
  }

  Future<void> _updateBorrower(Borrower borrower) async {
    try {
      await BorrowerService.updateBorrower(borrower);
      await _loadBorrower();
    } catch (e) {
      // Handle update error
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBooksByBorrower();
    _loadBorrower();
  }

  Future<void> _showEditDialog(Borrower borrower) async {
    TextEditingController _nameController =
        TextEditingController(text: borrower.fullName);
    TextEditingController _addressController =
        TextEditingController(text: borrower.address);
    TextEditingController _phoneController =
        TextEditingController(text: borrower.phoneNumber);
    TextEditingController _emailController =
        TextEditingController(text: borrower.email);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isReadOnly = false;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Edit'),
                    Switch(
                      value: isReadOnly,
                      onChanged: (bool newValue) {
                        setState(() {
                          isReadOnly = newValue;
                        });
                      },
                    ),
                  ],
                ),
                RoundedTextField(
                  readOnly: !isReadOnly,
                  controller: _nameController,
                  hintText: 'Name',
                ),
                RoundedTextField(
                  readOnly: !isReadOnly,
                  controller: _addressController,
                  hintText: 'Địa chỉ',
                ),
                RoundedTextField(
                  readOnly: !isReadOnly,
                  controller: _phoneController,
                  hintText: 'Phone',
                ),
                RoundedTextField(
                  readOnly: !isReadOnly,
                  controller: _emailController,
                  hintText: 'Email',
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () async {
                  final updatedBorrower = Borrower(
                    id: borrower.id,
                    fullName: _nameController.text,
                    address: _addressController.text,
                    phoneNumber: _phoneController.text,
                    email: _emailController.text,
                  );
                  await _updateBorrower(updatedBorrower);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _fetchBooksByBorrower() async {
    final borrowers = await BorrowerService.fetchAll();
    final List<Future<List<Book>>> bookFutures = borrowers
        .map((borrower) => BorrowService.getBooksByBorrower(borrower.id!))
        .toList();

    final List<List<Book>> booksList = await Future.wait(bookFutures);

    setState(() {
      booksByBorrower = booksList;
    });
  }

  void _showBooksScreen(int borrowerId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookScreen(borrowerId: borrowerId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'Find Borrower',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: primaryBlack,
                            width: 2.0,
                          ),
                        ),
                        hintText: _selectedOption == SearchOption.Name
                            ? 'Name'
                            : _selectedOption == SearchOption.Address
                                ? 'Address'
                                : _selectedOption == SearchOption.Phone
                                    ? 'Phone'
                                    : 'Email',
                        prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.search)),
                        prefixIconColor: primaryBlack,
                        // fillColor: primaryBlack,
                      ),
                      onChanged: (value) {
                        final query = _searchController.text;
                        _searchBorrowers(query);
                      },
                    ),
                  ),
                  PopupMenuButton<SearchOption>(
                    icon: Icon(Icons.filter_list_sharp),
                    initialValue: _selectedOption,
                    onSelected: (SearchOption option) {
                      setState(() {
                        _selectedOption = option;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<SearchOption>>[
                      PopupMenuItem<SearchOption>(
                        value: SearchOption.Name,
                        child: Text('Name'),
                      ),
                      PopupMenuItem<SearchOption>(
                        value: SearchOption.Address,
                        child: Text('Address'),
                      ),
                      PopupMenuItem<SearchOption>(
                        value: SearchOption.Phone,
                        child: Text('Phone'),
                      ),
                      PopupMenuItem<SearchOption>(
                        value: SearchOption.Email,
                        child: Text('Email'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('ID')),
                    Expanded(flex: 3, child: Text('Tên')),
                    Expanded(flex: 2, child: Text('Address')),
                    Expanded(flex: 2, child: Text('Phone')),
                    Expanded(flex: 2, child: Text('Email')),
                    Expanded(flex: 1, child: Text('Khác')),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                  child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final borrower = _searchResults[index];
                  return Container(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Row(children: <Widget>[
                          Expanded(child: Text('${borrower.id}')),
                          Expanded(flex: 3, child: Text(borrower.fullName)),
                          Expanded(flex: 2, child: Text('${borrower.address}')),
                          Expanded(
                              flex: 2, child: Text('${borrower.phoneNumber}')),
                          Expanded(flex: 2, child: Text('${borrower.email}')),
                          Expanded(
                            flex: 2,
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_horiz),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Text("Thông tin chi tiết"),
                                  ),
                                  PopupMenuItem<int>(
                                      value: 1, child: Text("Sách đang mượn")),
                                  PopupMenuItem<int>(
                                    value: 2,
                                    child: Text("Xóa"),
                                  ),
                                ];
                              },
                              onSelected: (value) {
                                if (value == 0) {
                                  _showEditDialog(borrower);

                                  // _showBorrowedBook(borrower.id!);
                                }
                                if (value == 1) {
                                  _showBooksScreen(borrower.id!);
                                }
                                if (value == 2) {
                                  _deleteBorrower(borrower.id!);
                                }
                              },
                            ),
                          )
                        ]),
                      ),
                      Divider(),
                    ]),
                  );
                },
              ))
            ],
          )),
    );
  }
}
