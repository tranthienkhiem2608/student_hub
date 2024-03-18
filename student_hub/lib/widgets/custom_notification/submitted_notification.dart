import 'package:flutter/material.dart';

class SubmittedNotification extends StatefulWidget {
  const SubmittedNotification({Key? key}) : super(key: key);

  @override
  _SubmittedNotificationState createState() => _SubmittedNotificationState();
}

class _SubmittedNotificationState extends State<SubmittedNotification> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      Row(
      children: <Widget>[
        const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black,
          child: Icon(Icons.accessibility_new_outlined, color: Colors.white, size: 30,)
        ),
        SizedBox(width: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'You have submitted to join project "Javis - AI Copilot"',
                style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '6/6/2024',
                style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 13.0),
              ),
            ],
          ),
        ),

      ],
    ),
    SizedBox(height: 10),
        Divider(),
    ],
    );

  }
}