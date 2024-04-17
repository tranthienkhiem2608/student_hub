import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import thư viện Google Fonts
import 'package:student_hub/view_models/controller_route.dart';

enum Role { student, company }

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
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

class _ChooseRoleState extends State<ChooseRole>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  Role? _role;

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
          0.3, // Start fading in at 30% of the animation duration
          0.8, // Fully faded in at 80% of the animation duration
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
                  height: 35,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(text: 'Join as '),
                                  TextSpan(
                                      text: 'Company',
                                      style:
                                          TextStyle(color: Color(0xFF406AFF))),
                                  TextSpan(text: ' or '),
                                  TextSpan(
                                      text: 'Student',
                                      style:
                                          TextStyle(color: Color(0xFF406AFF))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                // creta collum with cross axis alignment center and main axis sapce even
                Column(
                  children: [
                    // create row with main axis space even and black border
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // create container with width 150 and height 150
                        SlideTransition(
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
                            child: Container(
                              width: 600,
                              height: 120,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.grey.withOpacity(
                                      0.2), // Màu border và opacity
                                  width: 0.5, // Độ rộng của border
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/icons/student.png'),
                                        ),
                                        onPressed: () {
                                          // Xử lý khi người dùng nhấn vào biểu tượng người dùng
                                        },
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'I am a student',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'I\'m find a project & company',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Radio<Role>(
                                        value: Role.student,
                                        groupValue: _role,
                                        activeColor: Color(0xFF406AFF),
                                        onChanged: (val) {
                                          setState(() {
                                            _role = val;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        // create container with width 150 and height 150
                        SlideTransition(
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
                            child: Container(
                              width: 600,
                              height: 120,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 0.5,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/icons/company.png'),
                                        ),
                                        onPressed: () {
                                          // Xử lý khi người dùng nhấn vào biểu tượng người dùng
                                        },
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'I\'m a company',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'I\'m find engineer for project',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Radio<Role>(
                                        value: Role.company,
                                        groupValue: _role,
                                        activeColor: Color(0xFF406AFF),
                                        onChanged: (val) {
                                          setState(() {
                                            _role = val;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Đặt nút ở phía bên phải
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.5),
                            end: const Offset(0, 0),
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.6,
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
                                if (_role == null) {
                                  //show dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Choose your role'),
                                        content: const Text(
                                            'Please choose your role'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  ); // cần edit lại dialog
                                } else {
                                  ControllerRoute(context)
                                      .navigateToSignupInfoView(_role!.index);
                                }
                              },
                              height: 45,
                              color: Color(0xFF406AFF),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Create account",
                                style: GoogleFonts.poppins(
                                    // Thay đổi TextStyle này
                                    color: Colors.white,
                                    fontSize: 16.0),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?  ',
                      style: GoogleFonts.poppins(
                        // Thay đổi TextStyle này
                        color: Color(0xFF777B8A),
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Xử lý khi nút được nhấn
                        ControllerRoute(context).navigateToLoginView();
                      },
                      child: Text(
                        'Log in',
                        style: GoogleFonts.poppins(
                          // Thay đổi TextStyle này
                          color: Color(0xFF406AFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
