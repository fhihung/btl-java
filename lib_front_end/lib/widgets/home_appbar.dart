// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lib_app/widgets/constants.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback? press;
  // final String? textTitle;
  final Icon icon;
  HomeAppBar({
    Key? key,
    this.press,
    // this.textTitle,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: canvasColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: size.width * 0.05,
              ),
              Text(
                'Dashboard',
                style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {},
              child: FittedBox(
                child: Container(
                    decoration: BoxDecoration(
                        color: canvasColor,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    child: icon),
              )),
        ],
      ),
    );
  }
}
