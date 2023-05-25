import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  VoidCallback press;
  String textBtn;
  ButtonCustom({
    Key? key,
    required this.press,
    required this.textBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: press, child: Text(textBtn));
  }
}
