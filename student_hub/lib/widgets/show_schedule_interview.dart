import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ShowScheduleInterview extends StatefulWidget {
  User user;
  Notify notify;
  ShowScheduleInterview({required this.user, required this.notify});

  @override
  _ShowScheduleInterviewState createState() => _ShowScheduleInterviewState();
}

class _ShowScheduleInterviewState extends State<ShowScheduleInterview> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.notify.message!.interview!.title}",
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Duration: ${widget.notify.message!.interview!.duration}",
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "Start time: ${DateFormat('yyyy-MM-dd').format(widget.notify.message!.interview!.startTime!)} AT ${DateFormat('hh:mm a').format(widget.notify.message!.interview!.startTime!)}",
              style: GoogleFonts.poppins(
                  color: isDarkMode ? Colors.white : Colors.black),
            ),
            Text(
              "End time: ${DateFormat('yyyy-MM-dd').format(widget.notify.message!.interview!.endTime!)} AT ${DateFormat('hh:mm a').format(widget.notify.message!.interview!.endTime!)}",
              style: GoogleFonts.poppins(
                  color: isDarkMode ? Colors.white : Colors.black),
            ),
            Row(
              // or Row, depending on your layout
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print(widget.notify.message!.interview!.meetingRoom!
                        .meeting_room_id);
                    print(widget.notify.message!.interview!.meetingRoom!
                        .meeting_room_code);
                    ControllerRoute(context).navigateToVideoRoom(
                        widget.user,
                        widget.notify.message!.interview!.meetingRoom!
                            .meeting_room_code!);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4DBE3FF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Join Interview",
                    style: GoogleFonts.poppins(
                        color: Color(0xFF406AFF), fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
