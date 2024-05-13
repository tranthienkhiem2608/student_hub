import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/not_use/user_chat_model.dart';
import 'package:student_hub/services/socket_services.dart';
import 'package:student_hub/view_models/messages_viewModel.dart';

import 'package:student_hub/views/pages/chat_screen/chat_page.dart';
import 'package:student_hub/views/pages/chat_screen/chat_room.dart';
import 'package:student_hub/views/pages/chat_widgets/schedule_interview_page.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagePage extends StatefulWidget {
  const MessagePage(this.projectCompany, this.user,
      {required this.checkFlag, super.key});
  final int checkFlag;
  final ProjectCompany? projectCompany;
  final User? user;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;
  List<Message> filteredUsers = [];
  List<String> suggestions = []; // For search suggestions
  final TextEditingController _searchController = TextEditingController();
  List<Message> messages = [];
  late IO.Socket socket;
  late Timer? _timer;

  final List<UserChat> allUsers = [
    addison,
    angel,
    deanna,
    jason,
    judd,
    leslie,
    nathan,
    stanley,
    virgil,
  ];

  @override
  void initState() {
    super.initState();
    connect();
    fetchMessages().then((value) {
      setState(() {
        messages.addAll(value);
      });
    });
    tabController =
        TabController(length: 1, vsync: this); // Initialize tab controller
    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });

    filteredUsers.addAll(messages);
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) => connect());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _timer?.cancel();
    socket.disconnect();
    super.dispose();
  }

  void connect() {
    socket = SocketService().connectSocket();
    socket.connect();
  }

  Future<List<Message>> fetchMessages() async {
    List<Message> messages = await MessagesViewModel().getLastMessage();
    return messages;
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredUsers = messages
            .where((user) => user.sender!.fullname!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else {
        filteredUsers.clear();
        filteredUsers.addAll(messages);
      }
      updateSuggestions(query);
    });
  }

  void updateSuggestions(String query) {
    setState(() {
      if (query.isNotEmpty) {
        Set<String> uniqueSuggestions = {};
        allUsers
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .forEach((user) => uniqueSuggestions.add(user.name));
        suggestions = uniqueSuggestions.toList();
      } else {
        Set<String> uniqueSuggestions = {};
        allUsers.forEach((user) => uniqueSuggestions.add(user.name));
        suggestions = uniqueSuggestions.toList();
      }
    });
  }

  void showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for chats...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          filterUsers(newValue);
                          updateSuggestions(newValue);
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    if (suggestions.isNotEmpty)
                      Container(
                        constraints: BoxConstraints(maxHeight: 400.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Assuming 'suggestions' is a list of User objects (if not, adjust accordingly)
                            final selectedUserName = suggestions[index];
                            final user = messages.firstWhere((user) =>
                                user.sender!.fullname == selectedUserName);

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Colors.lightBlue, width: 1.0),
                                  // Customize color and width
                                ),
                                leading: const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                      'assets/images/avatar_default_img.png'),
                                ),
                                title: Text(user.sender!.fullname!),
                                onTap: () {
                                  _searchController.text = user
                                      .sender!.fullname!; // Update search field
                                  filterUsers(user
                                      .sender!.fullname!); // Trigger filtering
                                  Navigator.pop(
                                      context); // Close the bottom sheet
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatRoom(
                                        senderId: user.sender!.id!,
                                        receiverId: user.receiver!.id!,
                                        projectId: user.projectId!,
                                        senderName: user.sender!.fullname!,
                                        receiverName: user.receiver!.fullname!,
                                        user: widget.user!,
                                        flagCheck: 0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
        body: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: Color(0xFF406AFF),
              labelColor: Color(0xFF406AFF),
              dividerColor: isDarkMode
                  ? const Color.fromARGB(255, 47, 47, 47)
                  : Colors.white,
              labelStyle: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.bold),
              unselectedLabelColor: isDarkMode ? Colors.white : Colors.black,
              tabs: [
                Tab(text: 'All Chats'),
                Tab(text: 'Schedule interview'),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // adjust the value as needed
                child: TabBarView(
                  children: [
                    ChatPage(user: widget.user!, socket: socket),
                    ScheduleInterviewPage(user: widget.user!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
