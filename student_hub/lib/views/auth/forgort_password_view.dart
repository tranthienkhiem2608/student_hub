import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_hub/view_models/auth_account_viewModel.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
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

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool _showEmailError = false; // Flag to control error visibility
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<String> workEmailNotifier = ValueNotifier<String>('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      backgroundColor: Color(0xFFF2F5FC), // Set the background color here
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/forgot_img.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: // Replace with your image
                Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Reset Password",
                style: GoogleFonts.openSans(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 60.0, right: 60.0, bottom: 20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Enter the email address associated with your account.",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.7), // Set the color here
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set the background color here
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius here
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 5.0, left: 5.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email address",
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      TextField(
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
                          contentPadding: const EdgeInsets.all(0.0),
                          errorText: _showEmailError ? 'Invalid Email' : null,
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedErrorBorder: OutlineInputBorder(
                            // Change this
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Enter your email',
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
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Send',
                              style: GoogleFonts.openSans(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: workEmailNotifier.value.isNotEmpty
                                    ? Colors.lightBlue
                                    : Colors.grey
                                        .shade500, // Set the color conditionally here
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              child: MaterialButton(
                                onPressed: workEmailNotifier.value.isNotEmpty &&
                                        (_emailController.text.contains('@') ||
                                            !EmailValidator.validate(
                                                _emailController.text))
                                    ? () async {
                                        if (!EmailValidator.validate(
                                            _emailController.text)) {
                                          setState(() {
                                            _showEmailError =
                                                true; // Show error in TextField
                                          });
                                          return;
                                        }
                                        AuthAccountViewModel(context)
                                            .forgotPassword(
                                                workEmailNotifier.value);
                                      }
                                    : null,
                                color: Color(0xFF408cff).withOpacity(0.7),
                                disabledColor: Colors.grey.shade500,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ), // Replace with your icon
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      )),
    );
  }
}
