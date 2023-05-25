import 'package:flutter/material.dart';
import 'package:front_end/screens/overview_screen.dart';


import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

// import 'package:task_springboot/models/tasks_data.dart';
import 'models/books_data.dart';
// import 'screens/home_screen.dart';
import 'screens/homepage_screen.dart';
import 'widgets/constants.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashBoardScreen(),
      // ),
    );
  }
}
