import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class OfferNotification extends StatefulWidget {
  const OfferNotification({Key? key}) : super(key: key);

  @override
  _OfferNotificationState createState() => _OfferNotificationState();
}

class _OfferNotificationState extends State<OfferNotification> {
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
                  Icons.settings_outlined,
                  color: isDarkMode ? Colors.black : Colors.white,
                  size: 40,
                )),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'You have offder to join project "Javis - AI Copilot" ',
                    style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '6/6/2024',
                    style: GoogleFonts.poppins(
                        color: isDarkMode
                            ? Color.fromARGB(255, 213, 213, 213)
                            : Color.fromARGB(255, 72, 72, 72),
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500),
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF406AFF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text("View offer",
                          style: GoogleFonts.poppins(color: Colors.white)),
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
