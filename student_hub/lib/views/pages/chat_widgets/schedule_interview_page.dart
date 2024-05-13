import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/not_use/student_registered.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/notification_viewModel.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/widgets/show_schedule_interview.dart';
import 'package:student_hub/widgets/show_student_proposals_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ScheduleInterviewPage extends StatefulWidget {
  final User? user;
  ScheduleInterviewPage({Key? key, this.user}) : super(key: key);

  @override
  _ScheduleInterviewPageState createState() => _ScheduleInterviewPageState();
}

class _ScheduleInterviewPageState extends State<ScheduleInterviewPage> {
  List<Notify> notifyList = [];

  @override
  void initState() {
    super.initState();
    // companyId = widget.user!.companyUser!.id!;
    print("ID: ${widget.user!.id}");

    fetchNotify(widget.user!.id!).then((value) {
      if (mounted) {
        setState(() {
          print(value);
          //check if typeNotifyFlag is 1 wil add to list else not add
          for (var i = 0; i < value.length; i++) {
            if (value[i].typeNotifyFlag == "1" &&
                value[i].content != "Interview cancelled") {
              if (value[i].content == "Interview updated") {
                int index = notifyList.indexWhere((notify) =>
                    notify.message!.interview!.id ==
                    value[i].message!.interview!.id);
                if (index != -1) {
                  notifyList[index] = value[i];
                }
              } else {
                notifyList.add(value[i]);
              }
            }
          }
        });
      }
    });

    //print projectList;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          const Divider(),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: notifyList.length,
            itemBuilder: (context, index) {
              print("Length: ${notifyList.length}");
              final notify = notifyList[index];
              print(notify.id);
              print(notify.title);
              print(notify.content);
              if (notify.typeNotifyFlag == "1" &&
                  notify.content != "Interview cancelled" &&
                  notify.message!.interview!.endTime!.isAfter(DateTime.now())) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${notify.message!.interview!.title}",
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Duration: ${notify.message!.interview!.duration}",
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        "Start time: ${DateFormat('yyyy-MM-dd').format(notify.message!.interview!.startTime!)} AT ${DateFormat('hh:mm a').format(notify.message!.interview!.startTime!)}",
                        style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      Text(
                        "End time: ${DateFormat('yyyy-MM-dd').format(notify.message!.interview!.endTime!)} AT ${DateFormat('hh:mm a').format(notify.message!.interview!.endTime!)}",
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
                              print(notify.message!.interview!.meetingRoom!
                                  .meeting_room_id);
                              print(notify.message!.interview!.meetingRoom!
                                  .meeting_room_code);
                              ControllerRoute(context).navigateToVideoRoom(
                                  widget.user!,
                                  notify.message!.interview!.meetingRoom!
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
                      Divider()
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    ));
  }

  Future<List<Notify>> fetchNotify(int userId) async {
    List<Notify> messList = await NotifyViewModel().getAllNotifications(userId);
    return messList;
  }
}
