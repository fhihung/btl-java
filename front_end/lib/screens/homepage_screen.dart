// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sidebarx/sidebarx.dart';
import '../widgets/button_custom.dart';
import '../widgets/constants.dart';
import 'book_list_screen.dart';
import 'add_book_screen.dart';
import 'overview_screen.dart';
import 'search_book_screen.dart';

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        //Hiệu ứng khi rê chuột
        hoverColor: accentCanvasColor,

        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.person,
              color: white,
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.add_box,
          label: 'Add Book',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'Book List',
        ),
        const SidebarXItem(
          icon: Icons.favorite,
          label: 'Borrow Ticket',
        ),
        const SidebarXItem(
          iconWidget: FlutterLogo(size: 20),
          label: 'Flutter',
        ),
      ],
    );
  }
}

class ScreensExample extends StatelessWidget {
  const ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return DashBoardScreen();
          // ListView.builder(
          //   padding: const EdgeInsets.only(top: 10),
          //   itemBuilder: (context, index) => Container(
          //     height: 100,
          //     width: double.infinity,
          //     margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //       boxShadow: const [BoxShadow()],
          //     ),
          //   ),
          // );
          default:
            return pageTitle;
        }
      },
    );
  }
}

Widget getTitleByIndex(int index) {
  switch (index) {
    case 1:
      return AddBookScreen();
    case 2:
      return BookSearchScreen();
    // case 3:
    //   return 'Favorites';
    // case 4:
    //   return 'Custom iconWidget';
    // case 5:
    //   return 'Profile';
    // case 6:
    //   return 'Settings';
    default:
      return BookListScreen();
  }
}
