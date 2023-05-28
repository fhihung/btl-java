// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'constants.dart';

class RoundedTextField extends StatelessWidget {
  String hintText;
  bool readOnly;
  TextEditingController controller;
  RoundedTextField({
    Key? key,
    required this.hintText,
    required this.readOnly,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: TextField(
        maxLines: null,
        readOnly: readOnly!,
        controller: controller,
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
          hintText: hintText,
          prefixIconColor: primaryBlack,
          // fillColor: primaryBlack,
        ),
      ),
    );
  }
}
