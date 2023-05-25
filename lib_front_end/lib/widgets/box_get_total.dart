import 'package:flutter/material.dart';

import 'constants.dart';

class GetTotalContainer extends StatelessWidget {
  Icon icon;
  String text;
  Future<int> service;

  GetTotalContainer({
    Key? key,
    required this.icon,
    required this.text,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: service,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final int count = snapshot.data ?? 0;
          return Expanded(
              child: Container(
            padding: EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      count.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: icon,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 15),
                        child: Text(text)),
                  ],
                ),
              ],
            ),
          ));
        }
      },
    );
  }
}
