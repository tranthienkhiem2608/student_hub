import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _LoginPageState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  int? _selectedValue;

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
        appBar: const _AppBar(),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Màu chữ mặc định
                            ),
                            children: [
                              TextSpan(
                                text: "Welcome to ",
                              ),
                              TextSpan(
                                text: "Student Hub",
                                style: GoogleFonts.poppins(
                                    color: Color(
                                        0xFF406AFF)), // Màu chữ của "Student Hub"
                              ),
                            ],
                          ),
                        ),
                      ],
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
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: TextField(
                      cursorColor: Color(0xFF406AFF),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        hintText: 'Your company name',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF777B8A),
                          fontSize: 13.5,
                        ),
                        prefixIcon: const Icon(
                          Iconsax.building,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF4BEC0C7), width: 0.8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF4BEC0C7), width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
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
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: TextField(
                      cursorColor: Color(0xFF406AFF),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        hintText: 'Your company website',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF777B8A),
                          fontSize: 13.5,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: const Icon(
                          Iconsax.link,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF4BEC0C7), width: 0.8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF4BEC0C7), width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(
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
                    child: TextField(
                      cursorColor: Color(0xFF406AFF),
                      minLines: 5, // Đặt số dòng tối thiểu
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0), // Khoảng cách giữa đường viền và nội dung
                        hintText: 'Description',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF777B8A),
                          fontSize: 14.0,
                        ),
                         prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              bottom: 95.0),
                          child: Icon(
                            Iconsax.paperclip_2,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF4BEC0C7), width: 0.8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF4BEC0C7), width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
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
                            0.3, // Start sliding in at 30% of the animation duration
                            1, // Fully slid in at 100% of the animation duration
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
                              'How many people are in your company?',
                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                RadioListTile<int>(
                                  title: Text('It\'s just me',
                                      style: GoogleFonts.poppins(fontSize: 14)),
                                  dense: true,
                                  value: 100,
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = 100;
                                    });
                                  },
                                  activeColor: Color(0xFF406AFF),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Đặt nút ở phía bên phải
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0, -0.5),
                                  end: const Offset(0, 0))
                              .animate(
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
                            child: MaterialButton(
                              onPressed: () {
                                // Xử lý khi nút được nhấn
                              },
                              height: 45,
                              color: Color(0xFF4DBE3FF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Edit",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF406AFF), fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0, -0.5),
                                  end: const Offset(0, 0))
                              .animate(
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
                            child: MaterialButton(
                              onPressed: () {},
                              height: 45,
                              color: Color(0xFF406AFF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Continue",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 16.0),
                              ),
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
              ],
            ),
          ),
        ));
  }
}
