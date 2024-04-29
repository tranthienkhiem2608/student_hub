import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/user_chat_model.dart';
import 'package:student_hub/views/pages/chat_screen/chat_page.dart';
import 'package:student_hub/views/pages/chat_screen/chat_room.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;
  List<User> filteredUsers = [];
  List<String> suggestions = []; // For search suggestions
  final TextEditingController _searchController = TextEditingController();

  final List<User> allUsers = [
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
    tabController =
        TabController(length: 3, vsync: this); // Initialize tab controller
    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });

    super.initState();
    filteredUsers.addAll(allUsers);
    suggestions = allUsers.map((user) => user.name).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredUsers = allUsers
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredUsers.clear();
        filteredUsers.addAll(allUsers);
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
                          itemCount: suggestions.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Assuming 'suggestions' is a list of User objects (if not, adjust accordingly)
                            final selectedUserName = suggestions[index];
                            final user = allUsers.firstWhere(
                                (user) => user.name == selectedUserName);

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Colors.lightBlue, width: 1.0),
                                  // Customize color and width
                                ),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(user.avatar),
                                ),
                                title: Text(user.name),
                                onTap: () {
                                  _searchController.text =
                                      user.name; // Update search field
                                  filterUsers(user.name); // Trigger filtering
                                  Navigator.pop(
                                      context); // Close the bottom sheet
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatRoom(user: user),
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
                            color: isDarkMode ? Colors.white : Colors.black,// Choose your border color
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
                              color: isDarkMode ? Color.fromARGB(255, 98, 98, 98) : Colors.black,
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
              decoration: BoxDecoration(
                  // ... (your decoration here)
                  ),
              child: TabBarView(
                controller: tabController,
                children: [
                  ChatPage(),
                  Center(
                    child: Text('Camera'),
                  ),
                  Center(
                    child: Text('Call'),
                  ),
                ],
              ),
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
