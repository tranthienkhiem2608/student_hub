import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:student_hub/views/post_project/post_screen_4.dart';

import '../../widgets/theme/dark_mode.dart';

class PostScreen3 extends StatefulWidget {
  const PostScreen3({
    super.key,
    required this.project,
    required this.user,
  });
  final ProjectCompany project;
  final User user;

  @override
  State<PostScreen3> createState() => _PostScreen3State();
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

class _PostScreen3State extends State<PostScreen3>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  String description = ''; // To store the project description

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
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
        appBar: const _AppBar(),
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
                                text: 'projectpost3_project1'.tr(),
                                style: GoogleFonts.poppins(
                                    color: Color(
                                        0xFF406AFF)), // Thay đổi màu cho phần này
                              ),
                              TextSpan(
                                  text: "projectpost3_project2".tr(),
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
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
                      child: Column(
                        // Add Column to contain heading and list
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('projectpost3_project3'.tr(),
                              style: GoogleFonts.poppins(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              )),
                          SizedBox(
                              height: 6), // Spacing between heading and list
                          BulletedList(
                            bulletColor:
                                isDarkMode ? Colors.white : Colors.black,
                            style: GoogleFonts.poppins(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                            ),
                            listItems: [
                              'projectpost3_project4'.tr(),
                              'projectpost3_project5'.tr(),
                              'projectpost3_project6'.tr(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.3, // Khởi đầu animation sau khi phần trên đã xuất hiện
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      // Introduce a Row widget
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Align content to the start
                      children: [
                        Expanded(
                          // Expand the Column to take up available space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'projectpost3_project7'.tr(),
                                style: GoogleFonts.poppins(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
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
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          // Update state on changes
                          description = value;
                        });
                      },
                      minLines: 5, // Introduce multiline support
                      maxLines: null, // Allow the box to grow vertically
                      keyboardType: TextInputType
                          .multiline, // Adjust keyboard for multiline
                      cursorColor: Color(0xFF406AFF),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(
                            10.0), // Add padding within the box
                        hintText: 'projectpost3_project8'.tr(),
                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode
                              ? Color.fromARGB(255, 171, 171, 171)
                              : Colors.grey,
                          fontSize: 15.0,
                        ),
                        prefixIcon: Padding(
                            padding: EdgeInsets.only(bottom: 95.0),
                            child: Icon(
                              Iconsax.paperclip_2,
                              color: isDarkMode ? Colors.white : Colors.black,
                              size: 18,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF777B8A), width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF777B8A), width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
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
                            widget.project.description = description;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostScreen4(
                                  project: widget.project,
                                  user: widget.user,
                                ),
                              ),
                            );
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
                            "projectpost3_project9".tr(),
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
