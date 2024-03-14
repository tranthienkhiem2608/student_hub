import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/models/student_user.dart';
import 'package:student_hub/view_models/authentication_controller_route.dart';
import 'package:student_hub/views/homescreen/welcome-screen.dart';
import 'package:student_hub/views/pages/dashboard_page.dart';
import 'package:student_hub/views/pages/projects_page.dart';
import 'package:student_hub/views/profile_creation/student/home_view.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class PostScreen4 extends StatefulWidget {
  const PostScreen4(
      {super.key,
      required this.projectName,
      required this.duration,
      required this.numberOfStudents,
      required this.description});
  final String projectName;
  final String duration;
  final String numberOfStudents;
  final String description;

  @override
  State<PostScreen4> createState() => _PostScreen4State();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.blueAccent,
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
          onPressed: () {},
        ),
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
      expectations = widget.description.split('\n');
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Student Hub',
            style: TextStyle(
                color: Colors.blueAccent,
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
              // User profile action can be handled here
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Detail',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              'Project Name: ${widget.projectName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            const Divider(
              height: 12,
              thickness: 1.5,
              color: Color.fromARGB(255, 54, 52, 52),
            ),
            const SizedBox(height: 20),
            const Text(
              'Student are looking for:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Sử dụng ListView để hiển thị danh sách các mục với dấu chấm đầu dòng
            ListView(
              shrinkWrap: true,
              children: expectations.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 6),
                        width: 8, // Độ rộng của dấu chấm
                        height: 8, // Chiều cao của dấu chấm
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black, // Màu của dấu chấm
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(item)),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            const Divider(
              height: 12,
              thickness: 1.5,
              color: Color.fromARGB(255, 54, 52, 52),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(top: 6),
                width: 40, // Adjust the width for the larger icon
                height: 40, // Adjust the height for the larger icon
                child: Icon(Icons.watch_later_outlined, size: 40),
              ),
              title: Text(
                'Project scope:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${widget.duration} months',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Container(
                margin: const EdgeInsets.only(top: 6),
                width: 40, // Adjust the width for the larger icon
                height: 40, // Adjust the height for the larger icon
                child: Icon(Icons.people_alt_outlined, size: 40),
              ),
              title: Text(
                'Student required:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${widget.numberOfStudents} students',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
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
                        // ... (your code for gathering project data) ...
                        // ... (your code for sending data to the backend) ...

                        // Simple navigation without passing data
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      height: 55, // Increased height
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40), // Increased padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        "Post job",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
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
