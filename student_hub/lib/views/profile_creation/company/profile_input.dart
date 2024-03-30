import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:student_hub/models/model/company_user.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';

class ProfileInput extends StatefulWidget {
  final User user;
  const ProfileInput(this.user, {super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
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
  int _size = 0;

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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to Student Hub',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tell us about your company and you will be', // Dòng trên
                          textAlign: TextAlign.center, // Căn giữa
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'on your way connect with high-skilled students', // Dòng dưới
                          textAlign: TextAlign.center, // Căn giữa
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How many people are in your company?',
                              style: TextStyle(fontSize: 17),
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
                              title: const Text('It\'s just me',
                                  style: TextStyle(fontSize: 14)),
                              dense: true,
                              value: 100,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = 'It\'s just me';
                                  _size = 0;
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
                                0.4, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<int>(
                              title: const Text('2-9 employees',
                                  style: TextStyle(fontSize: 14)),
                              dense: true,
                              value: 200,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = '2-9 employees';
                                  _size = 9;
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
                                0.4, // Khởi đầu animation sau khi phần trên đã xuất hiện
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: RadioListTile<int>(
                              title: const Text('10-99 employees',
                                  style: TextStyle(fontSize: 14)),
                              dense: true,
                              value: 300,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = '10-99 employees';
                                  _size = 99;
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
                              title: const Text('100-1000 employees',
                                  style: TextStyle(fontSize: 14)),
                              dense: true,
                              value: 400,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = '100-1000 employees';
                                  _size = 1000;
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
                              title: const Text('More than 1000 employees',
                                  style: TextStyle(fontSize: 14)),
                              dense: true,
                              value: 500,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                  _numberOfEmployees = 'More than 1000 employees';
                                  _size = 1001;
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
                      onChanged: (value) {
                        _companyName = value;
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelText: 'Company Name',
                        hintText: 'Your Company Name!',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        prefixIcon: const Icon(
                          Iconsax.building,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
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
                      onChanged: (value) {
                        _website = value;
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelText: 'Website',
                        hintText: 'Your Company Website!',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        labelStyle: const TextStyle(
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
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
                      onChanged: (value) {
                        _description = value;
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 40.0,
                            horizontal:
                                20.0), // Khoảng cách giữa đường viền và nội dung
                        labelText: 'Description',
                        hintText: 'Description',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        prefixIcon: const Icon(
                          Iconsax.note_add,
                          color: Colors.black,
                          size: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
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
                            CompanyUser userCompany = CompanyUser(
                              id: widget.user.fullname!,
                              user: widget.user,
                              companyName: _companyName ?? '',

                              website: _website ?? '',
                              description: _description ?? '',
                              size: _size ?? 0,
                              // isLogin: false,
                            );

                            //print userCompany to cmd
                            print(userCompany.companyName);
                            print(userCompany.website);
                            print(userCompany.description);
                            print(userCompany.size);

                            ControllerRoute(context)
                                .navigateToWelcomeView(userCompany);
                          },
                          height: 45,
                          color: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Text(
                            "Continue",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
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
