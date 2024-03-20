import 'package:flutter/material.dart';

class InvitedNotification extends StatefulWidget {
  const InvitedNotification({Key? key}) : super(key: key);

  @override
  _InvitedNotificationState createState() => _InvitedNotificationState();
}


class _InvitedNotificationState extends State<InvitedNotification> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.settings_outlined, color: Colors.black, size: 40,)
            ),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'You have invited to interview for project "Javis - AI Copilot" at 14:00 March 20, Thursday "',
                    style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '6/6/2024',
                    style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 13.0),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle send action here
                        // Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text("Join", style: TextStyle(color: Colors.white)),
                    ),
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