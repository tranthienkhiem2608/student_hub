import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';
import 'package:student_hub/views/pages/chat_screen/chat_room.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AllChats extends StatefulWidget {
  final User user;
  final IO.Socket socket;

  const AllChats({required this.user, required this.socket, Key? key})
      : super(key: key);

  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  List<Message> messages = [];
  late Message newMess;

  @override
  void initState() {
    super.initState();
    fetchMessages().then((value) {
      setState(() {
        messages.addAll(value);
      });
      setStateForMessUnRead(messages);
    });
    widget.socket.onConnect((data) {
      print("Connected: ${widget.socket.connected}");
      print("Data: $data");
    });
    print("SOCKET: ${widget.socket.connected}");
    print('User ID: NOTI_${widget.user.id}');
    widget.socket.on('NOTI_${widget.user.id}', (data) {
      print("Content: $data");
      setState(() {
        newMess = Message.fromNewMessage(data);
        for (int i = 0; i < messages.length; i++) {
          if (newMess.sender!.id == messages[i].sender!.id &&
              newMess.projectId == messages[i].project!.id) {
            messages[i].checkRead = true;
            messages[i].content = newMess.content;
            messages[i].createAt = newMess.createAt;
            saveSenderUnRead(newMess.sender!.id, newMess.projectId!);
            break;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    widget.socket.off('NOTI_${widget.user.id}');
    super.dispose();
  }

  void saveSenderUnRead(int? senderId, int projectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> unReadList = prefs.getStringList('unReadList') ?? [];
    //check if senderId is already in the list
    print('Sender ID: $unReadList');
    String senderIdString = "$senderId/$projectId";
    if (!unReadList.contains(senderIdString)) {
      unReadList.add(senderIdString);
      prefs.setStringList('unReadList', unReadList);
    }
  }

  void setStateForMessUnRead(List<Message> messages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> unReadList = prefs.getStringList('unReadList') ?? [];
    print('Unread List: $unReadList');
    print('Messages: $messages');
    for (int i = 0; i < messages.length; i++) {
      String senderIdString =
          "${messages[i].sender!.id}/${messages[i].project!.id}";
      if (unReadList.contains(senderIdString)) {
        print(senderIdString);
        messages[i].checkRead = true;
      }
    }
  }

  Future<List<Message>> fetchMessages() async {
    List<Message> messages = await MessagesViewModel().getLastMessage();
    return messages;
  }

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
            itemCount: messages.length,
            itemBuilder: (context, int index) {
              final allChat = messages[index];
              if (widget.user.id == allChat.receiver!.id) {
                return Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(
                              'assets/images/avatar_default_img.png'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            allChat.checkRead = false;
                            //remove senderId from unReadList
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            List<String> unReadList =
                                prefs.getStringList('unReadList') ?? [];
                            String senderIdString =
                                "${allChat.sender!.id}/${allChat.project!.id}";
                            if (unReadList.contains(senderIdString)) {
                              unReadList.remove(senderIdString);
                              prefs.setStringList('unReadList', unReadList);
                            }
                            ControllerRoute(context).navigateToChatRoom(
                                allChat.receiver!.id!,
                                allChat.sender!.id!,
                                allChat.project!.id!,
                                allChat.receiver!.fullname!,
                                allChat.sender!.fullname!,
                                widget.user,
                                0);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                allChat.sender!.fullname!,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                allChat.project!.title!,
                                style: MyTheme.bodyText1.copyWith(
                                  color: MyTheme.bodyText2.color,
                                ),
                              ),
                              Text(
                                allChat.content!.split(' ').take(5).join(' ') +
                                    (allChat.content!.split(' ').length > 5
                                        ? '...'
                                        : ''),
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
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(allChat.createAt!)),
                              style: MyTheme.bodyTextTime,
                            ),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(DateTime.parse(allChat.createAt!)),
                              style: MyTheme.bodyTextTime,
                            ),
                            allChat.checkRead == true
                                ? const Icon(
                                    Icons.circle_notifications,
                                    color: Colors.blue,
                                    size: 10,
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ));
              } else {
                return Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(
                              'assets/images/avatar_default_img.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            ControllerRoute(context).navigateToChatRoom(
                                allChat.sender!.id!,
                                allChat.receiver!.id!,
                                allChat.project!.id!,
                                allChat.sender!.fullname!,
                                allChat.receiver!.fullname!,
                                widget.user,
                                0);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                allChat.receiver!.fullname!,
                                style: MyTheme.heading2.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                allChat.project!.title!,
                                style: MyTheme.bodyText1.copyWith(
                                  color: MyTheme.bodyText2.color,
                                ),
                              ),
                              Text(
                                'You: ${allChat.content!.split(' ').take(3).join(' ') + (allChat.content!.split(' ').length > 3 ? '...' : '')}',
                                style: MyTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(allChat.createAt!)),
                              style: MyTheme.bodyTextTime,
                            ),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(DateTime.parse(allChat.createAt!)),
                              style: MyTheme.bodyTextTime,
                            )
                          ],
                        ),
                      ],
                    ));
              }
            })
      ],
    );
  }
}
