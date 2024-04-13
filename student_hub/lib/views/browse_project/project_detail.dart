import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/views/browse_project/submit_proposal.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectCompany project;

  const ProjectDetailPage({Key? key, required this.project}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Details',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF406AFF)),
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
                            FontWeight.bold), // Thay đổi màu cho phần này
                  ),
                  TextSpan(
                    text: project.title,
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
                    Icon(Icons.search), // Add an Icon widget here
                    SizedBox(height: 10), // Add spacing between icon and text
                    SizedBox(width: 12), // Add spacing between icon and text
                    Text(
                      'Student are looking for:',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  children: project.description!.split('\n').map((item) {
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                              child: Text(item,
                                  style: GoogleFonts.poppins(fontSize: 15.5))),
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
                child: Icon(Icons.watch_later_outlined, size: 25),
              ),
              title: Text(
                'Project scope:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${_getProjectDurationText(ProjectDuration.values[project.projectScopeFlag ?? 0])}',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 5),
                width: 20, // Adjust the width for the larger icon
                height: 20, // Adjust the height for the larger icon
                child: Icon(Icons.people_alt_outlined, size: 25),
              ),
              title: Text(
                'Student required:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${project.numberOfStudents} students',
                style: GoogleFonts.poppins(fontSize: 15.5),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút "Apply Now" được nhấn
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApplyPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4DBE3FF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Save project",
                    style: GoogleFonts.poppins(color: Color(0xFF406AFF), fontSize: 16.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF406AFF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Apply now",
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16.0),
                  ),
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
      return 'Less than 1 month';
    case ProjectDuration.oneToThreeMonths:
      return '1 to 3 months';
    case ProjectDuration.threeToSixMonths:
      return '3 to 6 months';
    case ProjectDuration.moreThanSixMonth:
      return 'More than 6 months';
  }
}
