import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Thêm thư viện google_fonts

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:student_hub/models/model/company_user.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/input_profile_viewModel.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ProfileInput extends StatefulWidget {
  final User user;
  const ProfileInput(this.user, {Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key});

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

class _LoginPageState extends State<ProfileInput>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  int? _selectedValue;
  String _companyName = '';
  String _website = '';
  String _description = '';
  String _numberOfEmployees = '';
  int? _size;

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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to Student Hub',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF406AFF),
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tell us about your company and you will be', // Dòng trên
                          textAlign: TextAlign.center, // Căn giữa
                          style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Color.fromARGB(255, 168, 171, 185)
                                : Color(0xFF777B8A),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'on your way connect with high-skilled students', // Dòng dưới
                          textAlign: TextAlign.center, // Căn giữa
                          style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Color.fromARGB(255, 168, 171, 185)
                                : Color(0xFF777B8A),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                              'How many people are in your company?',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black),
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
                                0.35, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<int>(
                              title: Text('It\'s just me',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              dense: true,
                              value: 100,
                              groupValue: _selectedValue,
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF406AFF)),
                              activeColor: Color(0xFF406AFF),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(
                                      0xFF406AFF); // Màu khi radio được chọn
                                }
                                return isDarkMode
                                    ? Colors.white
                                    : Colors
                                        .black; // Màu khi radio không được chọn
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = 'It\'s just me';
                                  _size = 0;
                                });
                              },
                              // Thay đổi màu ở đây
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
                            child: RadioListTile<int>(
                              title: Text('2-9 employees',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              dense: true,
                              value: 200,
                              groupValue: _selectedValue,
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF406AFF)),
                              activeColor: Color(0xFF406AFF),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(
                                      0xFF406AFF); // Màu khi radio được chọn
                                }
                                return isDarkMode
                                    ? Colors.white
                                    : Colors
                                        .black; // Màu khi radio không được chọn
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = '2-9 employees';
                                  _size = 1;
                                });
                              },
                              // Thay đổi màu ở đây
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
                            child: RadioListTile<int>(
                              title: Text('10-99 employees',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              dense: true,
                              value: 300,
                              groupValue: _selectedValue,
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF406AFF)),
                              activeColor: Color(0xFF406AFF),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(
                                      0xFF406AFF); // Màu khi radio được chọn
                                }
                                return isDarkMode
                                    ? Colors.white
                                    : Colors
                                        .black; // Màu khi radio không được chọn
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = '10-99 employees';
                                  _size = 2;
                                });
                              },
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
                                0.45, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<int>(
                              title: Text('100-1000 employees',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              dense: true,
                              value: 400,
                              groupValue: _selectedValue,
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF406AFF)),
                              activeColor: Color(0xFF406AFF),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(
                                      0xFF406AFF); // Màu khi radio được chọn
                                }
                                return isDarkMode
                                    ? Colors.white
                                    : Colors
                                        .black; // Màu khi radio không được chọn
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = '100-1000 employees';
                                  _size = 3;
                                });
                              },
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
                                0.5, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<int>(
                              title: Text('More than 1000 employees',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                              dense: true,
                              value: 500,
                              groupValue: _selectedValue,
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF406AFF)),
                              activeColor: Color(0xFF406AFF),
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color(
                                      0xFF406AFF); // Màu khi radio được chọn
                                }
                                return isDarkMode
                                    ? Colors.white
                                    : Colors
                                        .black; // Màu khi radio không được chọn
                              }),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees =
                                      'More than 1000 employees';
                                  _size = 4;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onChanged: (value) {
                        _companyName = value;
                      },
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
                          color: isDarkMode
                              ? Color.fromARGB(255, 160, 160, 160)
                              : const Color.fromARGB(255, 110, 110, 110),
                          fontSize: 14.0,
                        ),
                        prefixIcon: Icon(
                          Iconsax.building,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color.fromARGB(255, 91, 91, 91)
                                  : Color.fromARGB(244, 48, 48, 49),
                              width: 0.8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDarkMode ? Color.fromARGB(244, 141, 141, 141) : Color.fromARGB(244, 48, 48, 49), width: 1),
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
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onChanged: (value) {
                        _website = value;
                      },
                      cursorColor: Color(0xFF406AFF),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        hintText: 'Your company website!',
                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode
                              ? Color.fromARGB(255, 160, 160, 160)
                              : const Color.fromARGB(255, 110, 110, 110),
                          fontSize: 14.0,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Iconsax.link,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color.fromARGB(255, 91, 91, 91)
                                  : Color.fromARGB(244, 48, 48, 49),
                              width: 0.8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDarkMode ? Color.fromARGB(244, 141, 141, 141) :Color.fromARGB(244, 48, 48, 49), width: 1),
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
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onChanged: (value) {
                        _description = value;
                      },
                      cursorColor: Color(0xFF406AFF),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 40.0,
                            horizontal:
                                20.0), // Khoảng cách giữa đường viền và nội dung
                        hintText: 'Description',
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode
                              ? Color.fromARGB(255, 160, 160, 160)
                              : const Color.fromARGB(255, 110, 110, 110),
                          fontSize: 14.0,
                        ),
                        prefixIcon: Icon(
                          Iconsax.note_add,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color.fromARGB(255, 91, 91, 91)
                                  : Color.fromARGB(244, 48, 48, 49),
                              width: 0.8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDarkMode ? Color.fromARGB(244, 141, 141, 141) : Color.fromARGB(244, 48, 48, 49), width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Đặt nút ở phía bên phải
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0, -0.5),
                              end: const Offset(0, 0))
                          .animate(
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
                            print("fullname: ${widget.user.fullname}");
                            widget.user.companyUser = CompanyUser(
                              id: widget.user.id!,
                              createAt: '',
                              updatedAt: '',
                              deletedAt: '',
                              userID: widget.user.id!,
                              companyName: _companyName ?? '',
                              website: _website ?? '',
                              description: _description ?? '',
                              size: _size ?? 0,
                              // isLogin: false,
                            );

                            //print userCompany to cmd
                            print(widget.user.companyUser?.companyName);
                            print(widget.user.companyUser?.website);
                            print(widget.user.companyUser?.description);
                            print(widget.user.companyUser?.size);
                            InputProfileViewModel(context)
                                .inputProfileCompany(widget.user);
                            // ControllerRoute(context)
                            //     .navigateToWelcomeView(widget.user);
                          },
                          height: 45,
                          color: Color(0xFF406AFF),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
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
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
