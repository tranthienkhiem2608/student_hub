import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/services/socket_services.dart';
import 'package:student_hub/view_models/nav_bottom_controller.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';
import 'package:student_hub/views/pages/alert_page.dart';
import 'package:student_hub/views/pages/dashboard_page.dart';
import 'package:student_hub/views/pages/message_page.dart';
import 'package:student_hub/views/pages/projects_page.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  final User? user;
  final bool showAlert;
  final int? pageDefault;

  const HomePage(
      {this.showAlert = false, this.user, this.pageDefault, Key? key})
      : super(key: key);

  // void functionInitialize({bool? shoAlert, CompanyUser? userCompany, StudentUser? userStudent, Key? key}) {
  //     if()
  // }

  @override
  _HomePageState createState() => _HomePageState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final User? user;
  const _AppBar({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Student Hub',
          style: GoogleFonts.poppins(
              // Apply the Poppins font
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
      actions: <Widget>[
        IconButton(
          icon: Container(
            // Add a Container as the parent
            padding: const EdgeInsets.all(8.0), // Padding for spacing
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  isDarkMode ? Colors.white : Colors.black, BlendMode.srcIn),
              child: Image.asset('assets/icons/user_ic.png',
                  width: 25, height: 25),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SwitchAccountView(user!)));
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _pages;
  late BottomNavController _navController;

  @override
  void initState() {
    super.initState();
    _navController = BottomNavController(pageDefault: widget.pageDefault!);

    _pages = [
      ProjectsPage(widget.user!),
      DashboardPage(widget.user!),
      MessagePage(
        null,
        widget.user,
        checkFlag: 0,
      ),
      AlertPage(widget.user),
    ];
    if (widget.showAlert == true) {
      Future.delayed(Duration.zero, () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text:
              'Welcome to StudentHub, a marketplace to connect Student <> Real-world projects',
          title: 'Welcome',
          confirmBtnText: 'Next',
        );
      });
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
      appBar: _AppBar(user: widget.user!),
      body: PageView(
        controller: _navController.controller,
        children: _pages,
        physics:
            const NeverScrollableScrollPhysics(), // Prevent swiping between pages
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Color.fromARGB(255, 20, 20, 20)
                : Color(0xFF406AFF),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GNav(
              gap: 8,
              padding: const EdgeInsets.all(14),
              backgroundColor: Colors.transparent,
              activeColor: Color(0xFF406AFF),
              iconSize: 24,
              tabBackgroundColor: isDarkMode ? Color(0xFF2f2f2f) : Colors.white,
              tabs: [
                GButton(
                  icon: Icons.home_rounded,
                  text: 'home_home1'.tr(),
                  textStyle: GoogleFonts.poppins(
                    // Sử dụng GoogleFonts.poppins()
                    fontSize: 14, // Kích thước chữ
                    color: isDarkMode ? Colors.white : Color(0xFF406AFF),
                    fontWeight: FontWeight.w500,
                  ),
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.space_dashboard_rounded,
                  text: 'home_home2'.tr(),
                  textStyle: GoogleFonts.poppins(
                    // Sử dụng GoogleFonts.poppins()
                    fontSize: 14, // Kích thước chữ
                    color: isDarkMode ? Colors.white : Color(0xFF406AFF),
                    fontWeight: FontWeight.w500, // Màu chữ
                  ),
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.message_rounded,
                  text: 'home_home3'.tr(),
                  textStyle: GoogleFonts.poppins(
                    // Sử dụng GoogleFonts.poppins()
                    fontSize: 14, // Kích thước chữ
                    color: isDarkMode ? Colors.white : Color(0xFF406AFF),
                    fontWeight: FontWeight.w500,
                  ),
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: Icons.notifications_rounded,
                  text: 'home_home4'.tr(),
                  textStyle: GoogleFonts.poppins(
                    // Sử dụng GoogleFonts.poppins()
                    fontSize: 14, // Kích thước chữ
                    color: isDarkMode ? Colors.white : Color(0xFF406AFF),
                    fontWeight: FontWeight.w500,
                  ),
                  iconColor: Colors.white,
                ),
              ],
              selectedIndex: _navController.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _navController.selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      //       bottomNavigationBar: Container(
      //   color: const Color(0xFFBEEEF7),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      //     child: GNav(
      //       backgroundColor: const Color(0xFFBEEEF7),
      //       color: Colors.black.withOpacity(0.8),
      //       activeColor: Colors.black.withOpacity(0.8),
      //       tabBackgroundColor: const Color(0xFF69cde0).withOpacity(0.5),
      //       gap: 8,
      //       padding: const EdgeInsets.all(12),
      //       tabs: const [
      //         GButton(
      //           icon: Icons.list_alt_rounded,
      //           text: 'Projects',
      //         ),
      //         GButton(
      //           icon: Icons.dashboard_rounded,
      //           text: 'Dashboard',
      //         ),
      //         GButton(
      //           icon: Icons.messenger_outline_rounded,
      //           text: 'Message',
      //         ),
      //         GButton(
      //           icon: Icons.notifications,
      //           text: 'Alerts',
      //         ),
      //       ],
      //       selectedIndex: _navController.selectedIndex,
      //       onTabChange: (index) {
      //         setState(() {
      //           _navController.selectedIndex = index;
      //         });
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
