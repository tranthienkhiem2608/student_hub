import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class OfferNotify extends StatefulWidget {
  Notify notify;
  OfferNotify(this.notify, {Key? key}) : super(key: key);

  @override
  _OfferNotifyState createState() => _OfferNotifyState();
}

class _OfferNotifyState extends State<OfferNotify> {
  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds <= 0) {
      return 'Just now';
    } else if (diff.inSeconds < 60 && diff.inSeconds > 0) {
      return '${diff.inSeconds}s';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}mn';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).round()}w';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).round()}m';
    } else {
      return '${(diff.inDays / 365).round()}y';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Container(
      color:
          widget.notify.notifyFlag == "0" ? Colors.blue.withOpacity(0.3) : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                    radius: 25,
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    child: Icon(
                      Icons.work_outlined,
                      color: isDarkMode ? Colors.black : Colors.white,
                      size: 40,
                    )),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.notify.title}',
                        style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        timeAgo(DateTime.parse(widget.notify.createAt!)),
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF406AFF)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
        ),
      ),
    );
  }
}
