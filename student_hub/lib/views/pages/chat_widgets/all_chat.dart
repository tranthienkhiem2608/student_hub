import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';
import 'package:student_hub/views/pages/chat_screen/chat_room.dart';

class AllChats extends StatefulWidget {
  final User user;
  const AllChats({required this.user, Key? key}) : super(key: key);

  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetchMessages().then((value) {
      setState(() {
        messages.addAll(value);
      });
    });
  }

  Future<List<Message>> fetchMessages() async {
    List<Message> messages = await MessagesViewModel().getLastMessage();
    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                'All Chats',
                style: MyTheme.heading2,
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
                          onTap: () {
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
                                allChat.content!,
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
                                'You: ${allChat.content!}',
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
