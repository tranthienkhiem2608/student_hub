import 'package:flutter/material.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/user_chat_model.dart';
import 'package:student_hub/views/pages/chat_widgets/composer.dart';
import 'package:student_hub/views/pages/chat_widgets/conversation.dart';
import 'package:student_hub/widgets/schedule_interview_dialog.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required this.user}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
  final User user;
}

class _ChatRoomState extends State<ChatRoom> {
  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.schedule_send),
                    title: Text('Schedule an interview'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showScheduleInterviewDialog(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.cancel_outlined),
                    title: Text('Cancel'),
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: false,
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
                  style: MyTheme.chatSenderName,
                ),
                Text(
                  'online',
                  style: MyTheme.bodyText2.copyWith(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz_rounded),
            onPressed: () {
              _showOptions(context);
            },
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: MyTheme.kPrimaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(),
                  child: Conversation(user: widget.user),
                ),
              ),
            ),
            buildChatComposer()
          ],
        ),
      ),
    );
  }
}
