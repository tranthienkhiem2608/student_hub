import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constant/const_key.dart';
import 'package:student_hub/models/model/interview.dart';
import 'package:student_hub/models/model/meetingRoom.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/interview_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ScheduleInterviewDialog extends StatefulWidget {
  final User user;
  final int projectId;
  final int receiverId;
  Interview? interview;
  ScheduleInterviewDialog(
      {Key? key,
      required this.user,
      required this.projectId,
      required this.receiverId,
      this.interview})
      : super(key: key);

  @override
  _ScheduleInterviewDialogState createState() =>
      _ScheduleInterviewDialogState();
}

class _ScheduleInterviewDialogState extends State<ScheduleInterviewDialog> {
  DateTime? _selectedDateStart;
  TimeOfDay? _selectedTimeStart;
  DateTime? _selectedDateEnd;
  TimeOfDay? _selectedTimeEnd;
  // final ValueNotifier<String> _titleController = ValueNotifier<String>('');
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.interview?.title);
    //format date and time
    if (widget.interview != null) {
      if (widget.interview != null) {
        _selectedDateStart =
            DateTime.parse(widget.interview!.startTime.toString());
        _selectedTimeStart = TimeOfDay.fromDateTime(_selectedDateStart!);
        _selectedDateEnd = DateTime.parse(widget.interview!.endTime.toString());
        _selectedTimeEnd = TimeOfDay.fromDateTime(_selectedDateEnd!);
      }
    }
  }

  void _showDatePicker(String dateType) {
    showDatePicker(
      context: context,
      initialDate: dateType == 'start'
          ? _selectedDateStart ?? DateTime.now()
          : _selectedDateEnd ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    ).then((value) {
      if (value == null) {
        return;
      }
      print('Picked date: $value'); // Add this line
      setState(() {
        dateType == 'start'
            ? _selectedDateStart = value
            : _selectedDateEnd = value;
      });
      print(
          'Updated date: ${dateType == 'start' ? _selectedDateStart : _selectedDateEnd}'); // Add this line
    });
  }

  void _showTimePicker(String timeType) {
    showTimePicker(
      context: context,
      initialTime: timeType == 'start'
          ? _selectedTimeStart ?? TimeOfDay.now()
          : _selectedTimeEnd ?? TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        timeType == 'start'
            ? _selectedTimeStart = value
            : _selectedTimeEnd = value;
      });
    });
  }

  String calculateDuration(DateTime startDate, TimeOfDay startTime,
      DateTime endDate, TimeOfDay endTime) {
    if (startDate == null ||
        startTime == null ||
        endDate == null ||
        endTime == null) {
      return 'No duration selected';
    }

    // Combine date and time into DateTime objects
    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    DateTime endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );

    // Calculate duration
    Duration duration = endDateTime.difference(startDateTime);
    String durationStr = '';

    if (duration.inDays > 0) {
      durationStr += '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ';
    }
    if (duration.inHours.remainder(24) > 0) {
      durationStr +=
          '${duration.inHours.remainder(24)} hour${duration.inHours.remainder(24) > 1 ? 's' : ''} ';
    }
    if (duration.inMinutes.remainder(60) > 0) {
      durationStr +=
          '${duration.inMinutes.remainder(60)} minute${duration.inMinutes.remainder(60) > 1 ? 's' : ''}';
    }

    return durationStr.trim();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Container(
      // Thay đổi từ Padding thành Container và thêm thuộc tính color
      color: isDarkMode
          ? Color(0xFF212121)
          : Colors.white, // Thay đổi màu nền ở đây
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("message_message2".tr(),
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF406AFF))),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("message_message5".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                cursorColor: Color(0xFF406AFF),
                decoration: InputDecoration(
                  focusColor: Color(0xFF406AFF),
                  hintText: 'message_message6'.tr(),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDarkMode
                          ? Color.fromARGB(255, 147, 147, 147)
                          : Color.fromARGB(255, 66, 66, 66)),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10.0),
                ),
                maxLines: null,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("schedule_schedule4".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
              ),
              Row(
                children: <Widget>[
                  Text(
                    _selectedDateStart == null
                        ? 'popup_project5'.tr()
                        : DateFormat.yMd().format(_selectedDateStart!),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDarkMode
                          ? Color.fromARGB(255, 205, 205, 205)
                          : Color.fromARGB(255, 66, 66, 66),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month_sharp,
                        color: Color(0xFF406AFF)),
                    onPressed: () {
                      _showDatePicker('start');
                    },
                  ),
                  Text(
                    _selectedTimeStart == null
                        ? 'popup_project12'.tr()
                        : _selectedTimeStart?.format(context) ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDarkMode
                          ? Color.fromARGB(255, 205, 205, 205)
                          : Color.fromARGB(255, 66, 66, 66),
                    ),
                  ), // Add your DatePicker widget here
                  IconButton(
                    icon:
                        const Icon(Icons.access_time, color: Color(0xFF406AFF)),
                    onPressed: () async {
                      _showTimePicker('start');
                    },
                  ),
                  // Add your TimePicker widget here
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("schedule_schedule7".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    )),
              ),
              Row(
                children: <Widget>[
                  Text(
                    _selectedDateEnd == null
                        ? 'popup_project5'.tr()
                        : DateFormat.yMd().format(_selectedDateEnd!),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDarkMode
                          ? Color.fromARGB(255, 205, 205, 205)
                          : Color.fromARGB(255, 66, 66, 66),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month_sharp,
                        color: Color(0xFF406AFF)),
                    onPressed: () {
                      _showDatePicker('end');
                    },
                  ),
                  Text(
                    _selectedTimeEnd == null
                        ? 'popup_project12'.tr()
                        : _selectedTimeEnd?.format(context) ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDarkMode
                          ? Color.fromARGB(255, 205, 205, 205)
                          : Color.fromARGB(255, 66, 66, 66),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.access_time, color: Color(0xFF406AFF)),
                    onPressed: () {
                      _showTimePicker('end');
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _selectedDateStart != null &&
                          _selectedTimeStart != null &&
                          _selectedDateEnd != null &&
                          _selectedTimeEnd != null
                      ? '${'schedule_schedule10'.tr()}${calculateDuration(_selectedDateStart!, _selectedTimeStart!, _selectedDateEnd!, _selectedTimeEnd!)}'
                      : 'schedule_schedule22'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: isDarkMode
                        ? Color.fromARGB(255, 205, 205, 205)
                        : Color.fromARGB(255, 66, 66, 66),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isDarkMode ? Color(0xFF4DBE3FF) : Color(0xFF4DBE3FF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text("companyprofileedit_ProfileCreation2".tr(),
                        style: GoogleFonts.poppins(color: Color(0xFF406AFF))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isEmpty ||
                          _selectedDateStart == null ||
                          _selectedTimeStart == null ||
                          _selectedDateEnd == null ||
                          _selectedTimeEnd == null) {
                        //show dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(
                                  'message_message7'.tr()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      widget.interview != null
                          ? () {
                              print('update');
                              widget.interview!.title = _titleController.text;
                              widget.interview!.startTime = DateTime(
                                _selectedDateStart!.year,
                                _selectedDateStart!.month,
                                _selectedDateStart!.day,
                                _selectedTimeStart!.hour,
                                _selectedTimeStart!.minute,
                              );
                              widget.interview!.endTime = DateTime(
                                _selectedDateEnd!.year,
                                _selectedDateEnd!.month,
                                _selectedDateEnd!.day,
                                _selectedTimeEnd!.hour,
                                _selectedTimeEnd!.minute,
                              );
                              // Handle send action here
                              print(widget.interview!.toMapInterviewUpdate());
                              InterviewViewModel()
                                  .updateScheduleInterviews(widget.interview!);
                              Navigator.of(context).pop();
                            }()
                          : () {
                              String meetingCode = base64Encode(utf8.encode(
                                  '${_titleController.text}-${widget.user.id}-${widget.projectId}-${widget.receiverId}'));
                              widget.interview = Interview(
                                title: _titleController.text,
                                content:
                                    "${widget.user.fullname} ${'message_message8'.tr()}",
                                startTime: DateTime(
                                  _selectedDateStart!.year,
                                  _selectedDateStart!.month,
                                  _selectedDateStart!.day,
                                  _selectedTimeStart!.hour,
                                  _selectedTimeStart!.minute,
                                ),
                                endTime: DateTime(
                                  _selectedDateEnd!.year,
                                  _selectedDateEnd!.month,
                                  _selectedDateEnd!.day,
                                  _selectedTimeEnd!.hour,
                                  _selectedTimeEnd!.minute,
                                ),
                                projectId: widget.projectId,
                                senderId: widget.user.id,
                                receiverId: widget.receiverId,
                                meetingRoom: MeetingRoom(
                                    // meeting_room_id: appId.toString(),
                                    meeting_room_id: meetingCode,
                                    meeting_room_code: meetingCode),
                              );
                              // Handle send action here
                              print(widget.interview!.toMapInterview());
                              InterviewViewModel()
                                  .postScheduleInterviews(widget.interview!);
                              Navigator.of(context).pop();
                            }();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF406AFF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: widget.interview == null
                        ? Text("schedule_schedule16".tr(),
                            style: GoogleFonts.poppins(color: Colors.white))
                        : Text("schedule_schedule23".tr(),
                            style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
