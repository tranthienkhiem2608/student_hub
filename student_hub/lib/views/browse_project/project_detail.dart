import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/browse_project/submit_proposal.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ProjectDetailPage extends StatefulWidget {
  final ProjectCompany project;
  final User user;

  const ProjectDetailPage({Key? key, required this.project, required this.user})
      : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
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
            Text(
              'projectpost4_project2'.tr(),
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF406AFF)),
            ),
            SizedBox(height: 30),
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
                    text: 'projectpost4_project3'.tr(),
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
                    Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.black,),
                    SizedBox(height: 10),
                    SizedBox(width: 12),
                    Text(
                      'projectpost3_project3'.tr(),
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
                    ),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  children: widget.project.description!.split('\n').map((item) {
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
                'projectpost4_project4'.tr(),
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
              ),
              subtitle: Text(
                '${_getProjectDurationText(ProjectDuration.values[widget.project.projectScopeFlag ?? 0])}',
                style: GoogleFonts.poppins(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black,),
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
                'projectpost4_project5'.tr(),
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
              ),
              subtitle: Text(
                '${widget.project.numberOfStudents} ${'projectpost4_project6'.tr()}',
                style: GoogleFonts.poppins(fontSize: 15.5, color: isDarkMode ? Colors.white : Colors.black,),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<int>(
                  future: SharedPreferences.getInstance()
                      .then((prefs) => prefs.getInt('role') ?? 0),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data == 0) {
                        return ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4DBE3FF),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "projectpost4_project11".tr(),
                            style: GoogleFonts.poppins(
                                color: Color(0xFF406AFF), fontSize: 16.0),
                          ),
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
                FutureBuilder<int>(
                  future: SharedPreferences.getInstance()
                      .then((prefs) => prefs.getInt('role') ?? 0),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data == 0) {
                        return ElevatedButton(
                          onPressed: () {
                            // Xử lý khi nút "Apply Now" được nhấn
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApplyPage(
                                      project: widget.project,
                                      studentId: widget.user.studentUser!.id!,
                                      user: widget.user)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF406AFF),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "projectpost4_project12".tr(),
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 16.0),
                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}

// Helper method to get project duration text from enum
String _getProjectDurationText(ProjectDuration duration) {
  switch (duration) {
    case ProjectDuration.lessThanOneMonth:
      return 'projectlist_company5'.tr();
    case ProjectDuration.oneToThreeMonths:
      return 'projectlist_company6'.tr();
    case ProjectDuration.threeToSixMonths:
      return 'projectlist_company7'.tr();
    case ProjectDuration.moreThanSixMonth:
      return 'projectlist_company8'.tr();
  }
}
