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
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageProposalPage extends StatefulWidget {
  const MessageProposalPage(this.projectCompany, this.user,
      {required this.checkFlag, super.key});
  final int checkFlag;
  final ProjectCompany? projectCompany;
  final User? user;

  @override
  State<MessageProposalPage> createState() => _MessageProposalPageState();
}

class _MessageProposalPageState extends State<MessageProposalPage>
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
    connect();
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
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: InkWell(
                    onTap: () {
                      showSearchBottomSheet(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white
                              : Colors.black, // Choose your border color
                          width: 1.0, // Choose the border width
                        ),
                        borderRadius: BorderRadius.circular(
                            50.0), // Adjust the border radius as needed
                      ),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Search for chats...',
                          hintStyle: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Color.fromARGB(255, 98, 98, 98)
                                : Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          border: InputBorder
                              .none, // Remove default border of TextField
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // Show tab view by default
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  // ... (your decoration here)
                  ),
              child: ChatPage(user: widget.user!, socket: socket!), // Chat page
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Color(0xFF406AFF),
        child: Icon(
          currentTabIndex == 0
              ? Icons.message_outlined
              : currentTabIndex == 1
                  ? Icons.camera_alt
                  : Icons.call,
          color: Colors.white,
        ),
      ),
    );
  }
}
