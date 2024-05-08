import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/services/socket_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

Container buildChatComposer(IO.Socket _socket, int _projectId, int senderId,
    int receiverId, BuildContext context) {
  final isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
  String message = '';
  final TextEditingController _controller = TextEditingController();
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: isDarkMode ? Color(0xFF212121) : Colors.white,
    height: 100,
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFF406AFF),
          child: const Icon(
            Icons.today,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            height: 60,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Color.fromARGB(255, 58, 58, 58)
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: Color(0xFF406AFF),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black),
                    controller: _controller,
                    onChanged: (value) {
                      message = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message ...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                Icon(
                  Icons.attach_file,
                  color: Color(0xFF406AFF),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        CircleAvatar(
            backgroundColor: Color(0xFF406AFF),
            child: IconButton(
              icon: const Icon(Icons.send),
              color: Colors.white,
              onPressed: () {
                Message sendMessage = Message(
                  projectId: _projectId,
                  content: message,
                  messageFlag: 0,
                  sender: User(id: senderId),
                  receiver: User(id: receiverId),
                );
                MessagesViewModel().sendMessage(sendMessage);

                print('Trying to send message...');
                // if (_socket.connected) {
                //   print('Message sent');
                // } else {
                //   _socket.onConnect((_) {
                //     print('Connected to server and message sent');
                //   });
                // }
                //clear text field
                message = '';
                _controller.clear();
                print('finished');
              },
            ))
      ],
    ),
  );
}
