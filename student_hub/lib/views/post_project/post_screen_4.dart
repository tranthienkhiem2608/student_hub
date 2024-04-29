import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';

import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class PostScreen4 extends StatefulWidget {
  const PostScreen4({
    super.key,
    required this.project,
    required this.user,
  });
  final ProjectCompany project;
  final User user;
  @override
  State<PostScreen4> createState() => _PostScreen4State();
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

class _PostScreen4State extends State<PostScreen4>
    with SingleTickerProviderStateMixin {
  List<String> expectations = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
// To store the parsed expectations

  void _parseExpectations() {
    // Assuming your expectations are separated by newlines in the description
    setState(() {
      expectations = widget.project.description!.split('\n');
    });
  }

  @override
  void initState() {
    super.initState();
    _parseExpectations();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.6, 1, curve: Curves.fastOutSlowIn)),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
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
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '4 /4  ',
                    style: GoogleFonts.poppins(
                        color: Color(0xFF406AFF)), // Thay đổi màu cho phần này
                  ),
                  TextSpan(
                    text: "Project details",
                    style: GoogleFonts.poppins(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                )
                  ),
                ],
              ),
            ),
            SizedBox(height: 45),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 17.5,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Project name: ',
                    style: GoogleFonts.poppins(
                        fontWeight:
                            FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,), // Thay đổi màu cho phần này
                  ),
                  TextSpan(
                    text: widget.project.title,
                    style: GoogleFonts.poppins(color: Color(0xFF406AFF)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.black,), // Add an Icon widget here
                    SizedBox(height: 10), // Add spacing between icon and text
                    SizedBox(width: 12), // Add spacing between icon and text
                    Text(
                      'Student are looking for:',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
                    ),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  children: expectations.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 36),
                          Container(
                            margin: EdgeInsets.only(top: 8, right: 10),
                            width: 4,
                            height: 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Expanded(
                              child: Text(item,
                                  style: GoogleFonts.poppins(fontSize: 15.5, color: isDarkMode ? Colors.white : Colors.black,))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 5),
                width: 20, // Adjust the width for the larger icon
                height: 20, // Adjust the height for the larger icon
                child: Icon(Icons.watch_later_outlined, size: 25, color: isDarkMode ? Colors.white : Colors.black,),
              ),
              title: Text(
                'Project scope:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
              ),
              subtitle: Text(
                widget.project.projectScopeFlag == 0
                    ? '1-3 months'
                    : '3-6 months',
                style: GoogleFonts.poppins(fontSize: 15.5, color: isDarkMode ? Colors.white : Colors.black,),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 5),
                width: 20, // Adjust the width for the larger icon
                height: 20, // Adjust the height for the larger icon
                child: Icon(Icons.people_alt_outlined, size: 25, color: isDarkMode ? Colors.white : Colors.black,),
              ),
              title: Text(
                'Student required:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
              ),
              subtitle: Text(
                '${widget.project.numberOfStudents} students',
                style: GoogleFonts.poppins(fontSize: 15.5, color: isDarkMode ? Colors.white : Colors.black,),
              ),
            ),
            SizedBox(height: 25),
            SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0, -0.5), end: const Offset(0, 0))
                  .animate(CurvedAnimation(
                parent: _animationController,
                curve: const Interval(
                  0.6,
                  1,
                  curve: Curves.fastOutSlowIn,
                ),
              )),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  // Add a Row for alignment
                  mainAxisAlignment: MainAxisAlignment.end, // Align right
                  children: [
                    const Spacer(), // Push button to the right
                    MaterialButton(
                      onPressed: () async {
                        ProjectCompanyViewModel(context)
                            .postProject(widget.project, widget.user);
                      },
                      height: 55, // Increased height
                      color: Color(0xFF406AFF),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40), // Increased padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "Post job",
                        style: GoogleFonts.poppins(
                            // Thay đổi TextStyle này
                            color: Colors.white,
                            fontSize: 16.0),
                      ),
                    ),
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
