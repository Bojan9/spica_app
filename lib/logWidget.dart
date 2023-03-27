import 'package:flutter/material.dart';

// Widget to show the logs
class LogWidget extends StatelessWidget {
  final String title;
  final String time;
  final String dateStr;

  const LogWidget(
      {Key? key,
      required this.title,
      required this.time,
      required this.dateStr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(time),
            ],
          ),
        ));
  }
}