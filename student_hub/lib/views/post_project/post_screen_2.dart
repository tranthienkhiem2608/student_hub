import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/post_project/post_screen_3.dart';

class PostScreen2 extends StatefulWidget {
  const PostScreen2({super.key, required this.project, required this.user});
  final ProjectCompany project;
  final User user;

  @override
  State<PostScreen2> createState() => _PostScreen2State();
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

class _PostScreen2State extends State<PostScreen2>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  String numberOfStudents = ''; // To store the number of students

  ProjectDuration? selectedDuration; // Use the enum type

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          activeIndex++;

          if (activeIndex == 4) {
            activeIndex = 0;
          }
        });
      }
    });

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3, // Start fading in at 50% of the animation duration
          0.8, // Fully faded in at 100% of the animation duration
          curve: Curves.easeIn,
        ),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                text: '2 /4  ',
                                style: GoogleFonts.poppins(
                                    color: Color(
                                        0xFF406AFF)), // Thay đổi màu cho phần này
                              ),
                              TextSpan(
                                text: "Estimate the scope of your job",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                SizedBox(
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.5),
                      end: const Offset(0, 0),
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.3,
                          1,
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Consider the size of your project and the timeline",
                              style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 103, 107, 119),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.5),
                        end: const Offset(0, 0),
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.3, // Khởi đầu animation sau khi phần trên đã xuất hiện
                            1,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How long will your project take?',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-0.5, 0),
                            end: const Offset(0, 0),
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.4, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<ProjectDuration>(
                              title: Text('Less than 1 month',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                              value: ProjectDuration
                                  .lessThanOneMonth, // Use enum value
                              groupValue: selectedDuration,
                              onChanged: (value) {
                                setState(() {
                                  selectedDuration = value;
                                });
                              },
                               activeColor: Color(0xFF406AFF),
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-0.5, 0),
                            end: const Offset(0, 0),
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.4, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<ProjectDuration>(
                              title: Text('1 to 3 months',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                              value: ProjectDuration
                                  .oneToThreeMonths, // Use enum value
                              groupValue: selectedDuration,
                              onChanged: (value) {
                                setState(() {
                                  selectedDuration = value;
                                });
                              },
                               activeColor: Color(0xFF406AFF),
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-0.5, 0),
                            end: const Offset(0, 0),
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.4, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<ProjectDuration>(
                              title: Text('3 to 6 months',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                              value: ProjectDuration
                                  .threeToSixMonths, // Use enum value
                              groupValue: selectedDuration,
                              onChanged: (value) {
                                setState(() {
                                  selectedDuration = value;
                                });
                              },
                               activeColor: Color(0xFF406AFF),
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-0.5, 0),
                            end: const Offset(0, 0),
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.4, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<ProjectDuration>(
                              title: Text('More than 6 months',
                                  style: GoogleFonts.poppins(fontSize: 15)),
                              value: ProjectDuration
                                  .moreThanSixMonth, // Use enum value
                              groupValue: selectedDuration,
                              onChanged: (value) {
                                setState(() {
                                  selectedDuration = value;
                                });
                              },
                              activeColor: Color(0xFF406AFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -0.5),
                    end: const Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(
                        0.3, // Khởi đầu animation sau khi phần trên đã xuất hiện
                        1,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How many students do you want for this project?',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: TextField(
                      onChanged: (value) {
                        numberOfStudents = value; // Update state on changes
                      },
                      keyboardType:
                          TextInputType.number, // Ensure numeric keyboard
                      cursorColor: Color(0xFF406AFF),
                      decoration: InputDecoration(
                        
                        contentPadding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
                        hintText: 'Enter the number', 
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF777B8A),
                          fontSize: 14.0,
                        ),
                        // Adjust hint
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF777B8A), width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFF777B8A), width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
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
                          onPressed: () {
                            if (selectedDuration != null &&
                                numberOfStudents.isNotEmpty) {
                              if (int.tryParse(numberOfStudents) != null) {
                                int parsedNumberOfStudents =
                                    int.parse(numberOfStudents);
                                if (parsedNumberOfStudents >= 0) {
                                  // Ensure numberOfStudents is not negative
                                  widget.project.projectScopeFlag =
                                      selectedDuration!.value;
                                  widget.project.numberOfStudents =
                                      int.parse(numberOfStudents);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostScreen3(
                                        project: widget.project,
                                        user: widget.user,
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          height: 55, // Increased height
                          color: Color(0xFF406AFF),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 40), // Increased padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            "Next",
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
        ));
  }
}
