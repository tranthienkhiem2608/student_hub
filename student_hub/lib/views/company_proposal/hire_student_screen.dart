// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/pages/message_by_projectId_page.dart';
import 'package:student_hub/views/pages/message_page.dart';
import 'package:student_hub/views/pages/project_detail/detail_page.dart';
import 'package:student_hub/views/pages/project_detail/hired_page.dart';
import 'package:student_hub/views/pages/project_detail/proposals_page.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class HireStudentScreen extends StatefulWidget {
  final ProjectCompany projectCompany;
  final User user;
  final int initialTabIndex;

  const HireStudentScreen(
      {Key? key,
      required this.projectCompany,
      required this.user,
      required this.initialTabIndex})
      : super(key: key);

  @override
  _HireStudentScreenState createState() => _HireStudentScreenState();
}

class _HireStudentScreenState extends State<HireStudentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialTabIndex);

    print('index: ${_tabController.index}'); // Set initial index
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
        appBar: _AppBar(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 5, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.projectCompany.title!,
                  style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF406AFF)),
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Color(0xFF406AFF),
              labelColor: Color(0xFF406AFF),
              dividerColor: isDarkMode
                  ? const Color.fromARGB(255, 47, 47, 47)
                  : Colors.white,
              labelStyle: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.bold),
              unselectedLabelColor: isDarkMode ? Colors.white : Colors.black,
              tabs: [
                Tab(text: 'Proposals'),
                Tab(text: 'Details'),
                Tab(text: 'Messages'),
                Tab(text: 'Hired'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProposalsPage(
                    projectCompany: widget.projectCompany,
                    user: widget.user,
                  ),
                  DetailPage(projectCompany: widget.projectCompany),
                  MessageByProjectIdPage(
                      user: widget.user, projectId: widget.projectCompany.id!),
                  HiredPage(
                    projectCompany: widget.projectCompany,
                    user: widget.user,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return AppBar(
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
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
