import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';

import 'package:student_hub/models/user_chat_model.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class Conversation extends StatelessWidget {
  const Conversation({
    Key? key,
    required this.senderId,
    required this.receiverId,
    required this.socket,
    required this.projectId,
  }) : super(key: key);
  final int senderId;
  final int receiverId;
  final int projectId;
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
  }

  @override
  void dispose() {
    widget.socket.off('RECEIVE_MESSAGE');
    super.dispose();
  }

  Future<List<Message>> fetchMessages(int projectId, int receiverId) async {
    List<Message> messages =
        await MessagesViewModel().getAllOldMessages(projectId, receiverId);
    return messages;
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
          message.senderId == widget.senderId
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
                              color: isMe
                                  ? MyTheme.kAccentColor
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(isMe ? 12 : 0),
                                bottomRight: Radius.circular(isMe ? 0 : 12),
                              )),
                          child: Text(
                            messages[index].content!,
                            style: MyTheme.bodyTextMessage.copyWith(
                                color: isMe ? Colors.white : Colors.grey[800]),
                          ),
                        ),
                      ],
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
                          // Icon(
                          //   Icons.done_all,
                          //   size: 20,
                          //   color: MyTheme.bodyTextTime.color,
                          // ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    )
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
