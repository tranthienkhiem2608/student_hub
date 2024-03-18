import 'package:flutter/material.dart';

class MessagesNotification extends StatefulWidget {
  const MessagesNotification({Key? key}) : super(key: key);

  @override
  _MessagesNotificationState createState() => _MessagesNotificationState();
}

class _MessagesNotificationState extends State<MessagesNotification> {
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
                    'Alex Jor"',
                    style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'How are you doing?"',
                    style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14.0),
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