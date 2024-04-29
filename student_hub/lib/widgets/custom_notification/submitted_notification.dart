import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class SubmittedNotification extends StatefulWidget {
  const SubmittedNotification({Key? key}) : super(key: key);

  @override
  _SubmittedNotificationState createState() => _SubmittedNotificationState();
}

class _SubmittedNotificationState extends State<SubmittedNotification> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
                radius: 25,
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
                child: Icon(
                  Icons.accessibility_new_outlined,
                  color: isDarkMode ? Colors.black : Colors.white,
                  size: 30,
                )),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'You have submitted to join project "Javis - AI Copilot"',
                    style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '6/6/2024',
                    style: GoogleFonts.poppins(
                        color: isDarkMode ? Color.fromARGB(255, 213, 213, 213) : Color.fromARGB(255, 72, 72, 72),
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500),
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
