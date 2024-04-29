import 'package:student_hub/models/model/users.dart';

import '../chat_widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final User user;
  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RecentChats(
            user: user,
          ),
          SizedBox(height: 20),
          AllChats(user: user),
        ],
      ),
    );
  }
}
