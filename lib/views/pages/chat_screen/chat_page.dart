import 'package:student_hub/models/model/users.dart';

import '../chat_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatelessWidget {
  final User user;
  final IO.Socket socket;
  const ChatPage({
    required this.user,
    required this.socket,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AllChats(user: user, socket: socket),
        ],
      ),
    );
  }
}
