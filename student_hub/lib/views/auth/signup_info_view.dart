import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/services/connection_services.dart';
import 'package:student_hub/view_models/auth_account_viewModel.dart';
import 'package:student_hub/view_models/controller_route.dart';

class SignUpInfo extends StatefulWidget {
  final int typeUser;

  const SignUpInfo(this.typeUser, {Key? key}) : super(key: key);

  @override
  State<SignUpInfo> createState() => _SignUpInfoState();
}

class _SignUpInfoState extends State<SignUpInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  bool _obscurePassword = true;
  bool _showEmailError = false;
  final TextEditingController _emailController = TextEditingController();

  final ValueNotifier<String> fullNameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> workEmailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> passwordNotifier = ValueNotifier<String>('');
  final ValueNotifier<bool> checkboxNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {});
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3,
          0.8,
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
        title: const Text(
          'Student Hub',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFBEEEF7),
        actions: <Widget>[
          IconButton(
            icon: SizedBox(
              width: 25,
              height: 25,
              child: Image.asset('assets/icons/user_ic.png'),
            ),
            onPressed: () {
              ControllerRoute(context).navigateToSwitchAccountView();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, -0.5), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.3, 1, curve: Curves.fastOutSlowIn),
                )),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up as ${widget.typeUser == 0 ? 'student' : 'company'}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                onChanged: (value) => fullNameNotifier.value = value,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Your Full Name!',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.0),
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                  prefixIcon:
                      const Icon(Iconsax.user, color: Colors.black, size: 18),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10.0)),
                  floatingLabelStyle:
                      const TextStyle(color: Colors.black, fontSize: 18.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  workEmailNotifier.value = value;
                  setState(() {
                    _showEmailError = false;
                  });
                },
                controller: _emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Work Email',
                  hintText: 'Your Work Email!',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.0),
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                  prefixIcon:
                      const Icon(Iconsax.link, color: Colors.black, size: 18),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10.0)),
                  floatingLabelStyle:
                      const TextStyle(color: Colors.black, fontSize: 18.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10.0)),
                  errorText: _showEmailError ? 'Invalid Email' : null,
                  errorStyle: const TextStyle(color: Colors.red),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) => passwordNotifier.value = value,
                obscureText: _obscurePassword,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 14.0),
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                  prefixIcon:
                      const Icon(Iconsax.key, color: Colors.black, size: 18),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10.0)),
                  floatingLabelStyle:
                      const TextStyle(color: Colors.black, fontSize: 18.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(10.0)),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                        color: Colors.black),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: checkboxNotifier.value,
                    onChanged: (bool? value) {
                      setState(() {
                        checkboxNotifier.value = value!;
                      });
                    },
                  ),
                  const Text(
                    'Yes, I understand and agree to StudentHub',
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              MaterialButton(
                onPressed: fullNameNotifier.value.isNotEmpty &&
                        workEmailNotifier.value.isNotEmpty &&
                        passwordNotifier.value.isNotEmpty &&
                        checkboxNotifier.value &&
                        (_emailController.text.contains('@') ||
                            !EmailValidator.validate(_emailController.text))
                    ? () async {
                        if (!EmailValidator.validate(_emailController.text)) {
                          setState(() {
                            _showEmailError =
                                true; // Hiển thị lỗi trong TextField
                          });
                          return;
                        }

                        final user = User(
                          email: workEmailNotifier.value,
                          password: passwordNotifier.value,
                          fullname: fullNameNotifier.value,
                          role: widget.typeUser == 0 ? [0] : [1],
                        );

                        try {
                          // Gọi hàm post để tạo tài khoản
                          var response = await ConnectionService()
                              .post('/api/auth/sign-up', user.toMapUser());
                          // Kiểm tra response và hiển thị lỗi nếu có
                          if (response.containsKey('response')) {
                            var errorMessage =
                                response['err']['message'].join('\n');
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)));
                          }
                        } catch (e) {
                          print('Error: $e');
                          // Xử lý các lỗi khác nếu có
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to create account')));
                        }
                      }
                    : null,
                height: 45,
                color: Colors.black,
                disabledColor: Colors.grey.shade500,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Text(
                  "Create account",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 30),
              SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, -0.5), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.3, 1,
                            curve: Curves.fastOutSlowIn))),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Looking for a project? ',
                          style:
                              TextStyle(color: Colors.black, fontSize: 14.0)),
                      InkWell(
                        onTap: () {
                          if (widget.typeUser == 1) {
                            ControllerRoute(context)
                                .navigateToSignupInfoView(0);
                          } else {
                            ControllerRoute(context)
                                .navigateToSignupInfoView(1);
                          }
                        },
                        child: Text(
                          'Apply as ${widget.typeUser == 1 ? 'student' : 'company'}',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
