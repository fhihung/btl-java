import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// import 'package:task_springboot/models/tasks_data.dart';
import 'models/books_data.dart';
// import 'screens/home_screen.dart';
import 'screens/homepage_screen.dart';

// import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider<BooksData>(
        //   create: (context) => BooksData(),
        //   child:
        MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageScreen(),
      // ),
    );
  }
}
