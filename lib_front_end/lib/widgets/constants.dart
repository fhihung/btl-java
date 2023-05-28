import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 255, 255, 255);
const canvasColor = Color.fromARGB(255, 0, 0, 0);
const scaffoldBackgroundColor = Color.fromARGB(255, 236, 236, 236);
const accentCanvasColor = Color.fromARGB(255, 91, 91, 91);
const white = Colors.white;
final actionColor = Color.fromARGB(255, 255, 255, 255).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
