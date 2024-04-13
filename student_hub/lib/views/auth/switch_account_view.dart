import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';

import 'package:student_hub/view_models/auth_account_viewModel.dart';
import 'package:student_hub/widgets/add_account_widget.dart';
import 'package:student_hub/models/company_user.dart';

import '../homescreen/welcome_view.dart';

class SwitchAccountView extends StatefulWidget {
  final User user;
  const SwitchAccountView(this.user, {super.key});

  @override
  _SwitchAccountViewState createState() => _SwitchAccountViewState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

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
  int? role;

  @override
  void initState() {
    super.initState();
    setState(() {
      initPrefs();
    });
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getInt('role')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Hub',
            style: GoogleFonts.poppins(
                // Apply the Poppins font
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: <Widget>[
          IconButton(
            icon: Container(
              // Add a Container as the parent
              padding: const EdgeInsets.all(8.0), // Padding for spacing
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle,
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
                child: Image.asset('assets/icons/user_ic.png',
                    width: 25, height: 25),
              ),
            ),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          // If there are no accounts, show AddAccountWidget, else show a dropdown list of accounts
          accounts.isEmpty
              ? AddAccountWidget(widget.user)
              : TextButton(
                  onPressed: () {
                    // Settings button pressed
                    AuthAccountViewModel(context).showAccountList(widget.user);
                  },
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
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Transform.rotate(
                            angle: -90 *
                                3.14159 /
                                180, // Convert degrees to radians
                            child: const Icon(Icons.arrow_back_ios,
                                color: Colors.black, size: 18.0),
                          ),
                        ],
                      ),
                      Container(
                        width: 100, // Tăng giá trị width
                        height: 100, // Tăng giá trị height
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200], // Màu nền của hình tròn
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(
                            'assets/icons/company_account.png',
                          ),
                        ),
                      ),

                      SizedBox(
                          width: 10), // Khoảng cách giữa hình ảnh và văn bản
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
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

          const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            // Set the padding you want
          ),
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      AuthAccountViewModel(context).userProfile(widget.user);
                    },
                    icon: Image.asset(
                      'assets/icons/profile.jpg', // Đường dẫn của hình ảnh
                      // Màu của biểu tượng (nếu cần)
                      width: 28.0, // Chiều rộng của biểu tượng (nếu cần)
                      height: 28.0, // Chiều cao của biểu tượng (nếu cần)
                    ),
                    label: Text(
                      'Profiles',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
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
                      // Settings button pressed
                    },
                    icon: Image.asset(
                      'assets/icons/setting.jpg', // Đường dẫn của hình ảnh
                      // Màu của biểu tượng (nếu cần)
                      width: 28.0, // Chiều rộng của biểu tượng (nếu cần)
                      height: 28.0, // Chiều cao của biểu tượng (nếu cần)
                    ),
                    label: Text('Settings',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
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
                      // Màu của biểu tượng (nếu cần)
                      width: 28.0, // Chiều rộng của biểu tượng (nếu cần)
                      height: 28.0, // Chiều cao của biểu tượng (nếu cần)
                    ),
                    label: Text('Log out',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
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
