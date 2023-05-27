import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../widgets/constants.dart';
import 'book/add_book_screen.dart';
import 'book/book_list_screen.dart';
import 'borrow/list_screen.dart';
import 'borrow/request_borrow_screen.dart';
import 'borrower/borrower_list_screen.dart';
import 'overview_screen.dart';
import 'book/search_book_screen.dart';

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
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.black.withOpacity(0.2),
        textStyle: TextStyle(color: canvasColor.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
            // BoxShadow(
            //     color: Colors.black.withOpacity(0.28),
            //     blurRadius: 30,
            //  )
          ],
        ),
        iconTheme: IconThemeData(
          color: canvasColor.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        margin: EdgeInsets.all(10),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        const SidebarXItem(
          icon: Icons.favorite,
          label: 'Search',
        ),
        const SidebarXItem(
          icon: Icons.local_activity,
          label: 'Borrow',
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
        switch (controller.selectedIndex) {
          case 0:
            return DashBoardScreen();
          case 1:
            return BookSearchScreen();
          case 2:
            return BorrowListWidget();
          case 3:
            return BorrowRequestScreen();

          default:
            return DashBoardScreen();
        }
      },
    );
  }
}
