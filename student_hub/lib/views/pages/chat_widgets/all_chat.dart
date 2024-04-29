import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/message_model.dart';
import 'package:student_hub/views/pages/chat_screen/chat_room.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class AllChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                'All Chats',
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF406AFF),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: allChats.length,
            itemBuilder: (context, int index) {
              final allChat = allChats[index];
              return Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(allChat.avatar),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return ChatRoom(user: allChat.sender);
                          }));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              allChat.sender.name,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              allChat.text,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 151, 151, 151),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          allChat.unreadCount == 0
                              ? Icon(
                                  Icons.done_all,
                                  color: MyTheme.bodyTextTime.color,
                                )
                              : CircleAvatar(
                                  radius: 8,
                                  backgroundColor: MyTheme.kUnreadChatBG,
                                  child: Text(
                                    allChat.unreadCount.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            allChat.time,
                            style: MyTheme.bodyTextTime,
                          )
                        ],
                      ),
                    ],
                  ));
            })
      ],
    );
  }
}
