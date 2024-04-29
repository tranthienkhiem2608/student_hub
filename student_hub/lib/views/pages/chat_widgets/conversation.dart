import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/message_model.dart';

import 'package:student_hub/models/user_chat_model.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class Conversation extends StatelessWidget {
  const Conversation({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, int index) {
          final message = messages[index];
          bool isMe = message.sender.id == currentUser.id;
          return Container(
            margin: const EdgeInsets.only(top: 17),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isMe)
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(user.avatar),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          color: isDarkMode
                              ? isMe
                                  ? Color(0xFF406AFF)
                                  : Color.fromARGB(255, 66, 66, 66)
                              : isMe
                                  ? Color(0xFF406AFF)
                                  : Color.fromARGB(255, 228, 228, 228),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 12 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          )),
                      child: Text(
                        messages[index].text,
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
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe)
                        SizedBox(
                          width: 40,
                        ),
                      Icon(
                        Icons.done_all,
                        size: 17,
                        color: Color.fromARGB(255, 146, 146, 146),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        message.time,
                        style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 146, 146, 146),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
