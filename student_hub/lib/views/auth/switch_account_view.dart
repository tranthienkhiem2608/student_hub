import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';

import 'package:student_hub/view_models/auth_account_viewModel.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/widgets/add_account_widget.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class SwitchAccountView extends StatefulWidget {
  final User user;
  const SwitchAccountView(this.user, {Key? key}) : super(key: key);

  @override
  _SwitchAccountViewState createState() => _SwitchAccountViewState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFBEEEF7),
      actions: <Widget>[
        IconButton(
          icon: const SizedBox(
            width: 25,
            height: 25,
            child: Icon(Icons.search, color: Colors.black),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SwitchAccountViewState extends State<SwitchAccountView> {
  late SharedPreferences prefs;
  static const String darkModeKey = 'switchAccountDarkMode';
  int? role;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('role')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: isDarkMode ? Colors.white : Color(0xFF242526),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Student Hub',
            style: GoogleFonts.poppins(
                // Apply the Poppins font
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode
                  : Icons
                      .dark_mode, // Thay đổi biểu tượng dựa vào trạng thái chế độ
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Provider.of<DarkModeProvider>(context, listen: false)
                  .toggleDarkMode();
            }, // Gọi hàm khi nút được nhấn
          ),
        ],
      ),
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
      body: Column(
        children: <Widget>[
          // If there are no accounts, show AddAccountWidget, else show a dropdown list of accounts
          accounts.isEmpty
              ? AddAccountWidget(widget.user)
              : GestureDetector(
                  onTap: () {
                    AuthAccountViewModel(context).showAccountList(widget.user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                              child: Text("Switch account  ",
                                  style: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Transform.rotate(
                              angle: -90 *
                                  3.14159 /
                                  180, // Convert degrees to radians
                              child: Icon(Icons.arrow_back_ios,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors
                                          .black, // Đổi màu dựa trên trạng thái dark mode
                                  size: 18.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDarkMode
                                          ? Color.fromARGB(255, 90, 90, 90)!
                                          : Colors.grey[200]!,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Image.asset(
                              "${role == 0 ? 'assets/icons/student_account.png' : 'assets/icons/company_account.png'}",
                            ),
                          ),
                        ),

                        SizedBox(
                            width: 20), // Khoảng cách giữa hình ảnh và văn bản
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.user.fullname!}",
                              textAlign: TextAlign.center, // Căn giữa văn bản
                              style: GoogleFonts.poppins(
                                color: Color(0xFF406AFF),
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4), // Khoảng cách giữa hai phần
                            Text(
                              "${role == 0 ? 'Student' : 'Company'}",
                              textAlign: TextAlign.center, // Căn giữa văn bản
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

          const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            // Set the padding you want
          ),
          Container(
            color: isDarkMode ? Color(0xFF212121) : Colors.white,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      print(
                          'Techstack: ${widget.user.studentUser!.techStack!.name}');
                      print(
                          'Skillset: ${widget.user.studentUser!.skillSet!.map((e) => e.name)}');
                      print(
                          'Language: ${widget.user.studentUser!.languages!.map((e) => e.languageName)}');
                      print(
                          'Education: ${widget.user.studentUser!.education!.map((e) => e.schoolName)}');
                      // skillset in experience
                      print(
                          'Skillset in experience: ${widget.user.studentUser!.experience!.map((e) => e.skillSet!.map((e) => e.name))}');
                      AuthAccountViewModel(context).userProfile(widget.user);
                    },
                    icon: Image.asset(
                      'assets/icons/profile.jpg',
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 28.0,
                      height: 28.0,
                    ),
                    label: Text(
                      'Profiles',
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Divider(), // Set the padding you want
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      // ControllerRoute(context)
                      //       .navigateToEditProfileInputStudent(widget.user);
                    },
                    icon: Image.asset(
                      'assets/icons/setting.jpg', // Đường dẫn của hình ảnh
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 28.0, // Chiều rộng của biểu tượng (nếu cần)
                      height: 28.0, // Chiều cao của biểu tượng (nếu cần)
                    ),
                    label: Text('Settings',
                        style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Divider(), // Set the padding you want
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      // Log out button pressed
                      AuthAccountViewModel(context).logoutAccount();
                    },
                    icon: Image.asset(
                      'assets/icons/logout.jpg', // Đường dẫn của hình ảnh
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 28.0, // Chiều rộng của biểu tượng (nếu cần)
                      height: 28.0, // Chiều cao của biểu tượng (nếu cần)
                    ),
                    label: Text('Log out',
                        style: GoogleFonts.poppins(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}