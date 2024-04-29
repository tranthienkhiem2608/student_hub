import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/user_chat_model.dart';
import 'package:student_hub/views/pages/chat_widgets/composer.dart';
import 'package:student_hub/views/pages/chat_widgets/conversation.dart';
import 'package:student_hub/widgets/schedule_interview_dialog.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required this.user}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
  final User user;
}

class _ChatRoomState extends State<ChatRoom> {
  void _showOptions(BuildContext context) {
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
                        Icon(Icons.schedule_send, color: Color(0xFF406AFF)),
                    title: Text('Schedule an interview',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF406AFF))),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showScheduleInterviewDialog(context);
                    },
                  ),
                  Divider(color: isDarkMode ? Colors.white : Colors.black),
                  ListTile(
                    leading: Icon(
                      Icons.cancel_outlined,
                      color: Color.fromARGB(255, 255, 38, 74),
                    ),
                    title: Text('Cancel',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 38, 74))),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
        });
  }

  void _showScheduleInterviewDialog(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return const SingleChildScrollView(
              child: ScheduleInterviewDialog(),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: isDarkMode ? Colors.white : Color(0xFF242526),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 100,
        centerTitle: false,
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                widget.user.avatar,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  'online',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 108, 255, 113),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_horiz_rounded,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              _showOptions(context);
            },
          ),
        ],
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF212121) : Colors.white,
                  borderRadius: BorderRadius.only(),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(),
                  child: Conversation(user: widget.user),
                ),
              ),
            ),
            buildChatComposer(context)
          ],
        ),
      ),
    );
  }
}
