import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class MessagesNotification extends StatefulWidget {
  const MessagesNotification({Key? key}) : super(key: key);

  @override
  _MessagesNotificationState createState() => _MessagesNotificationState();
}

class _MessagesNotificationState extends State<MessagesNotification> {
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
                    'Alex Jor"',
                    style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'How are you doing?"',
                    style: GoogleFonts.poppins(
                        color: isDarkMode ? Color.fromARGB(255, 213, 213, 213) : Color.fromARGB(255, 72, 72, 72),
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500),
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
