import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:student_hub/app_theme.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/services/socket_services.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/views/pages/chat_widgets/composer.dart';
import 'package:student_hub/views/pages/chat_widgets/conversation.dart';
import 'package:student_hub/widgets/schedule_interview_dialog.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoom extends StatefulWidget {
  final int senderId;
  final int receiverId;
  final int projectId;
  final String senderName;
  final String receiverName;
  final User user;
  final int flagCheck;
  const ChatRoom(
      {super.key,
      required this.senderId,
      required this.receiverId,
      required this.projectId,
      required this.senderName,
      required this.receiverName,
      required this.user,
      required this.flagCheck});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
  }

  @override
  void dispose() {
    socket.disconnect();
    // socket.dispose();
    super.dispose();
  }

  void connect() {
    socket = SocketService().connectSocket();
    socket.io.options?['query'] = {'project_id': widget.projectId};
    print('query: ${socket.io.options?['query']}');
    print(socket.io.uri);
    socket.connect();

    socket.on('RECEIVE_MESSAGE', (data) {
      print("Chat room: $data");
    });
    socket.on('NOTI_${widget.user.id}', (data) {
      print(data);
    });

    socket.on('ERROR', (data) {
      print(data);
    });

    socket.onConnectError(
        (data) => print('Error connection: ${data.toString()}'));
    socket.onError((data) => print('Error connection: ${data.toString()}'));
  }

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

  void _showScheduleInterviewDialog(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ScheduleInterviewDialog(
                  user: widget.user,
                  projectId: widget.projectId,
                  receiverId: widget.receiverId,
                  interview: null),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: widget.flagCheck == 0
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: isDarkMode ? Colors.white : Color(0xFF242526),
                onPressed: () {
                  Navigator.of(context).pop();
                  ControllerRoute(context)
                      .navigateToHomeScreen(false, widget.user, 2);
                },
              )
            : IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: isDarkMode ? Colors.white : Color(0xFF242526),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                'assets/images/avatar_default_img.png',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiverName,
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
          FutureBuilder<int>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getInt('role') ?? 0),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != 0) {
                  return IconButton(
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      _showOptions(context);
                    },
                  );
                } else {
                  return SizedBox
                      .shrink(); // Return an empty widget if role is not 0
                }
              } else {
                return CircularProgressIndicator(); // Show a loading spinner while waiting for the future to complete
              }
            },
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Container(
              height: 10,
              color: isDarkMode ? Color(0xFF212121) : Colors.white,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF212121) : Colors.white,
                  borderRadius: BorderRadius.only(),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(),
                  child: Conversation(
                      senderId: widget.senderId,
                      receiverId: widget.receiverId,
                      projectId: widget.projectId,
                      user: widget.user,
                      socket: socket),
                ),
              ),
            ),
            buildChatComposer(socket, widget.projectId, widget.senderId,
                widget.receiverId, context),
          ],
        ),
      ),
    );
  }
}
