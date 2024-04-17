import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/auth_account_viewModel.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpInfo extends StatefulWidget {
  final int typeUser;
  const SignUpInfo(this.typeUser, {Key? key}) : super(key: key);

  @override
  State<SignUpInfo> createState() => _SignUpInfoState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

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

class _SignUpInfoState extends State<SignUpInfo>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  bool _obscurePassword = true; // Start with the password hidden
  bool _showEmailError = false; // Flag to control error visibility
  final TextEditingController _emailController = TextEditingController();

  int? _selectedValue;
  final ValueNotifier<String> fullNameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> workEmailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');
  final ValueNotifier<bool> checkboxNotifier = ValueNotifier<bool>(false);

  void handleChangeTypeUser() {
    if (widget.typeUser == 'Role.company') {
      ControllerRoute(context).navigateToSignupInfoView(0);
    } else {
      ControllerRoute(context).navigateToSignupInfoView(1);
    }
  }

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
                SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
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
                        Text.rich(
                          TextSpan(
                            text: 'Sign up as ',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.typeUser == 0
                                    ? 'Student'
                                    : 'Company',
                                style: TextStyle(
                                  color: Color(0xFF406AFF), // Màu xanh
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
                          .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.1,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: TextField(
                      onChanged: (value) => fullNameNotifier.value =
                          value, // Update fullNameNotifier when text changes
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 18.0),
                        hintText: 'Your full name',
                        labelStyle: GoogleFonts.poppins(
                          // Thay đổi TextStyle này
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          // Thay đổi TextStyle này
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        prefixIcon: Icon(
                          Iconsax.user,
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
                SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
                          .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.2,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: TextField(
                      onChanged: (value) {
                        workEmailNotifier.value = value;
                        setState(() {
                          _showEmailError = false; // Reset error on change
                        });
                      },
                      controller:
                          _emailController, // Controller for email input // Update workEmailNotifier when text changes
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 18.0),
                        errorText: _showEmailError ? 'Invalid Email' : null,
                        errorStyle: TextStyle(color: Colors.red),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Your work email!',
                        hintStyle: GoogleFonts.poppins(
                          // Thay đổi TextStyle này
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          // Thay đổi TextStyle này
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
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
                SizedBox(height: 20),
                SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
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
                      onChanged: (value) => passwordNotifier.value =
                          value, // Update passwordNotifier when text changes
                      obscureText:
                          _obscurePassword, // Use the visibility variable
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 18.0),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.poppins(
                          // Thay đổi TextStyle này
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          // Thay đổi TextStyle này
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Iconsax.key,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword; // Toggle visibility
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
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
                      children: [
                        Checkbox(
                          value: _selectedValue == 1,
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedValue = value! ? 1 : 0;
                              checkboxNotifier.value = value;
                            });
                          },
                          activeColor: Color(
                              0xFF406AFF), // Đặt màu xanh cho nút checkbox
                        ),
                        Text(
                          'Yes, I understand and agree to StudentHub',
                          style: GoogleFonts.poppins(
                            // Thay đổi TextStyle này
                            color: Color.fromARGB(255, 77, 80, 90),
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                            begin: Offset(0, -0.5),
                            end: Offset(0, 0),
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
                            child: MaterialButton(
                              onPressed: fullNameNotifier.value.isNotEmpty &&
                                      workEmailNotifier.value.isNotEmpty &&
                                      passwordNotifier.value.isNotEmpty &&
                                      checkboxNotifier.value &&
                                      (_emailController.text.contains('@') ||
                                          !EmailValidator.validate(
                                              _emailController
                                                  .text)) // Update this condition
                                  ? () async {
                                      if (!EmailValidator.validate(
                                          _emailController.text)) {
                                        setState(() {
                                          _showEmailError =
                                              true; // Show error in TextField
                                        });
                                        return;
                                      }
                                      final user = User(
                                        email: workEmailNotifier.value,
                                        password: passwordNotifier.value,
                                        fullname: fullNameNotifier.value,
                                        role: widget.typeUser == 0 ? [0] : [1],
                                      );
                                      print(user.fullname);
                                      print(user.email);
                                      print(user.password);
                                      print(user.role);
                                      // if (widget.typeUser == 'Role.company') {
                                      //   ControllerRoute(context)
                                      //       .navigateToProfileInputCompany(
                                      //           user);
                                      // } else {
                                      //   ControllerRoute(context)
                                      //       .navigateToProfileInputStudent1(
                                      //           user);
                                      // }

                                      AuthAccountViewModel(context)
                                          .signUpAccount(user);
                                    }
                                  : null,
                              height: 45,
                              color: Color(0xFF406AFF),
                              disabledColor: Colors.grey.shade500,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Create account",
                                style: GoogleFonts.poppins(
                                  // Thay đổi TextStyle này
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
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
                        Text(
                          'Looking for a project? ',
                          style: GoogleFonts.poppins(
                            // Thay đổi TextStyle này
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                        InkWell(
                          onTap: handleChangeTypeUser,
                          child: Text(
                            'Apply as ${widget.typeUser == 1 ? 'student' : 'company'}',
                            style: GoogleFonts.poppins(
                              // Thay đổi TextStyle này
                              color: Color(0xFF406AFF),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
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
