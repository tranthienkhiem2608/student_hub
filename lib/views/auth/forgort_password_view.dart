import 'package:easy_localization/easy_localization.dart';
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

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool _showEmailError = false; // Flag to control error visibility
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<String> workEmailNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // Set the background color here
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/forgot_img.png',
                  width: 500,
                  height: 300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "forgotpassword_auth6".tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF406AFF), // Set the color here
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 60.0, right: 60.0, bottom: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "forgotpassword_auth2".tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(244, 137, 139, 143), // Set the color here
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
                            "forgotpassword_auth4".tr(),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 18.0),
                          errorText: _showEmailError ? 'Invalid Email' : null,
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'forgotpassword_auth3'.tr(),
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 14.0,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 300,
                              height: 60,
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
                                color: Color(0xFF406AFF),
                                disabledColor: Colors.grey.shade500,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50.0), // Add border radius here
                                ),
                                child: Text(
                                  'forgotpassword_auth6'.tr(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(244, 255, 255,
                                        255), // Set the color conditionally here
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
