import 'package:flutter/material.dart';

class OfferNotification extends StatefulWidget {
  const OfferNotification({Key? key}) : super(key: key);

  @override
  _OfferNotificationState createState() => _OfferNotificationState();
}


class _OfferNotificationState extends State<OfferNotification> {
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
                    'You have offder to join project "Javis - AI Copilot" ',
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
                      child: const Text("View offer", style: TextStyle(color: Colors.white)),
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