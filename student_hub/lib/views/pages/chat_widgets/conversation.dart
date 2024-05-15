import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/model/interview.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/interview_viewModel.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';

import 'package:student_hub/models/not_use/user_chat_model.dart';
import 'package:student_hub/views/pages/chat_screen/video_conference_page.dart';
import 'package:student_hub/widgets/schedule_interview_dialog.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class Conversation extends StatefulWidget {
  const Conversation({
    Key? key,
    required this.senderId,
    required this.receiverId,
    required this.socket,
    required this.projectId,
    required this.user,
  }) : super(key: key);
  final int senderId;
  final int receiverId;
  final int projectId;
  final User user;
  final IO.Socket socket;

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    fetchMessages(widget.projectId, widget.receiverId).then((value) {
      setState(() {
        messages.addAll(value);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        });
      });
    });
    widget.socket.on('RECEIVE_MESSAGE', (data) {
      print("Content: $data");
      setState(() {
        messages.add(Message.fromNewMessage(data));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        });
      });
    });
    widget.socket.on('RECEIVE_INTERVIEW', (data) {
      print("Content have interview: $data");
      setState(() {
        Message message = Message.fromNewMessage(data);
        int index = messages.indexWhere((element) {
          return element.interview != null &&
              element.interview!.id == message.interview!.id;
        });

        if (index != -1) {
          messages[index] = message;
        } else {
          messages.add(message);
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        });
      });
    });
  }

  @override
  void dispose() {
    widget.socket.off('RECEIVE_MESSAGE');
    widget.socket.off('RECEIVE_INTERVIEW');
    super.dispose();
  }

  Future<List<Message>> fetchMessages(int projectId, int receiverId) async {
    List<Message> messages =
        await MessagesViewModel().getAllOldMessages(projectId, receiverId);
    return messages;
  }

  void _showOptions(BuildContext context, Interview interview) {
    bool isDarkMode =
        Provider.of<DarkModeProvider>(context, listen: false).isDarkMode;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 52, 52, 52) : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
          return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ListTile(
                    leading:
                        Icon(Icons.edit_document, color: Color(0xFF406AFF)),
                    title: Text('interview_student1'.tr(),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF406AFF))),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showScheduleInterviewDialog(context, interview);
                    },
                  ),
                  Divider(color: isDarkMode ? Colors.white : Colors.black),
                  ListTile(
                    leading: const Icon(
                      Icons.cancel_outlined,
                      color: Color.fromARGB(255, 255, 38, 74),
                    ),
                    title: Text('interview_student2'.tr(),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 38, 74))),
                    onTap: () {
                      Navigator.of(context).pop();
                      InterviewViewModel().disableInterview(interview);
                    },
                  ),
                ],
              ));
        });
  }

  void _showScheduleInterviewDialog(
    BuildContext ctx,
    Interview interview,
  ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ScheduleInterviewDialog(
                  user: widget.user,
                  projectId: widget.projectId,
                  receiverId: widget.receiverId,
                  interview: interview),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return ListView.builder(
        controller: _scrollController,
        reverse: false,
        itemCount: messages.length,
        itemBuilder: (context, int index) {
          final message = messages[index];
          bool isMe = true;
          // print(message.interview);
          message.sender!.id == widget.senderId
              ? isMe = true
              : isMe =
                  false; //message.senderId == widget.senderId ? true : false;
          return Column(
            children: [
              index < messages.length - 1 &&
                      !isSameDay(DateTime.parse(messages[index].createAt!),
                          DateTime.parse(messages[index + 1].createAt!))
                  ? Column(
                      children: [
                        Text(
                          "${DateFormat('yyyy-MM-dd').format(DateTime.parse(messages[index + 1].createAt!))} AT ${DateFormat('hh:mm a').format(DateTime.parse(message.createAt!))}",
                          style: MyTheme.bodyTextTime,
                        ),
                      ],
                    )
                  : Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.parse(message.createAt!)),
                      style: MyTheme.bodyTextTime,
                    ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: isMe == true
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isMe)
                          const CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                AssetImage('assets/images/user_img.png'),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          decoration: BoxDecoration(
                              color: isDarkMode
                                  ? isMe
                                      ? Color(0xFF406AFF)
                                      : Color.fromARGB(255, 66, 66, 66)
                                  : isMe
                                      ? Color(0xFF406AFF)
                                      : Color.fromARGB(255, 228, 228, 228),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(isMe ? 12 : 0),
                                bottomRight: Radius.circular(isMe ? 0 : 12),
                              )),
                          child: Text(
                            messages[index].content!,
                            style: GoogleFonts.poppins(
                                color: isDarkMode
                                    ? Colors.white
                                    : isMe
                                        ? Colors.white
                                        : Colors.black),
                          ),
                        ),
                      ],
                    ),
                    if (message.interview != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.8),
                          decoration: BoxDecoration(
                              color: isDarkMode
                                  ? isMe
                                      ? Color(0xFF406AFF)
                                      : Color.fromARGB(255, 66, 66, 66)
                                  : isMe
                                      ? Color(0xFF406AFF)
                                      : Color.fromARGB(255, 228, 228, 228),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${message.interview!.title}",
                                      style: GoogleFonts.poppins(
                                        color: isDarkMode
                                            ? Color.fromARGB(255, 255, 255, 255)
                                            : isMe
                                                ? Color.fromARGB(255, 0, 0, 0)
                                                : Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.more_horiz_rounded,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      _showOptions(context, message.interview!);
                                    },
                                  ),
                                ],
                              ),
                              
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${'schedule_schedule20'.tr()} ',
                                      style: GoogleFonts.poppins(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${DateFormat('dd/MM/yyyy').format(message.interview!.startTime!)} ',
                                      style: GoogleFonts.poppins(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${'schedule_schedule21'.tr()} ',
                                      style: GoogleFonts.poppins(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${DateFormat('hh:mm a').format(message.interview!.startTime!)} - ${DateFormat('hh:mm a').format(message.interview!.endTime!)}',
                                      style: GoogleFonts.poppins(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${'interview_student3'.tr()} ',
                                      style: GoogleFonts.poppins(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${message.interview!.duration}',
                                      style: GoogleFonts.poppins(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              message.interview!.disableFlag == 0
                                  ? () {
                                      return Row(
                                        // or Row, depending on your layout
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              print(message
                                                  .interview!
                                                  .meetingRoom!
                                                  .meeting_room_id);
                                              print(message
                                                  .interview!
                                                  .meetingRoom!
                                                  .meeting_room_code);
                                              ControllerRoute(context)
                                                  .navigateToVideoRoom(
                                                      widget.user,
                                                      message
                                                          .interview!
                                                          .meetingRoom!
                                                          .meeting_room_code!);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xFF4DBE3FF),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Text(
                                              "schedule_schedule19".tr(),
                                              style: GoogleFonts.poppins(
                                                  color: Color(0xFF406AFF),
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                        ],
                                      );
                                    }()
                                  : () {
                                      return Row(
                                          // or Row, depending on your layout
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "schedule_schedule18".tr(),
                                              style: GoogleFonts.poppins(
                                                color: const Color.fromARGB(
                                                    255, 255, 38, 74),
                                                fontSize: 14.0,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]);
                                    }(),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isMe)
                            const SizedBox(
                              width: 40,
                            ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
