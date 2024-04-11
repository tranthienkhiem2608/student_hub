import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/nav_bottom_controller.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';
import 'package:student_hub/views/pages/alert_page.dart';
import 'package:student_hub/views/pages/dashboard_page.dart';
import 'package:student_hub/views/pages/message_page.dart';
import 'package:student_hub/views/pages/projects_page.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';

class HomePage extends StatefulWidget {
  final User? user;
  final bool? showAlert;

  const HomePage({this.showAlert = false, this.user, Key? key})
      : super(key: key);

  // void functionInitialize({bool? shoAlert, CompanyUser? userCompany, StudentUser? userStudent, Key? key}) {
  //     if()
  // }

  @override
  _HomePageState createState() => _HomePageState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  User? user;
   _AppBar(this.user, {super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Student Hub',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFBEEEF7),
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('assets/icons/user_ic.png'),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SwitchAccountView(user!)));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _pages;
  final BottomNavController _navController = BottomNavController();

  @override
  void initState() {
    super.initState();
    print(widget.user!.companyUser!.id);
    _pages = [
      const ProjectsPage(),
      DashboardPage(widget.user!),
      const MessagePage(),
      AlertPage(),
    ];
    if (widget.showAlert!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text:
              'Welcome to StudentHub, a marketplace to connect Student <> Real-world projects',
          title: 'Welcome',
          showConfirmBtn: true,
          customAsset: 'assets/alerts/success.gif',
          confirmBtnText: 'Next',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(widget.user),
      body: PageView(
        controller: _navController.controller,
        children: _pages,
        physics:
            const NeverScrollableScrollPhysics(), // Prevent swiping between pages
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFBEEEF7),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: GNav(
            backgroundColor: const Color(0xFFBEEEF7),
            color: Colors.black.withOpacity(0.8),
            activeColor: Colors.black.withOpacity(0.8),
            tabBackgroundColor: const Color(0xFF69cde0).withOpacity(0.5),
            gap: 8,
            padding: const EdgeInsets.all(12),
            tabs: const [
              GButton(
                icon: Icons.list_alt_rounded,
                text: 'Projects',
              ),
              GButton(
                icon: Icons.dashboard_rounded,
                text: 'Dashboard',
              ),
              GButton(
                icon: Icons.messenger_outline_rounded,
                text: 'Message',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Alerts',
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
    );
  }
}
