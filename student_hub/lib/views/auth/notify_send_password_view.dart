import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/view_models/auth_account_viewModel.dart';
import 'package:student_hub/view_models/controller_route.dart';

class NotifySendPassword extends StatefulWidget {
  final String email;
  const NotifySendPassword(this.email, {super.key});
  @override
  State<NotifySendPassword> createState() => _NotifySendPasswordState();
}

class _NotifySendPasswordState extends State<NotifySendPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FC), // Set the background color here
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 120, 30, 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/check_mail_img.png',
              width: 300,
              height: 300,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 30, 0),
          child: // Replace with your image
              Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Check your mail",
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue, // Set the color here
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 50.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "We have sent a password recover instructions to your mail.",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black.withOpacity(0.7), // Set the color here
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 80,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              // Handle send action here
              ControllerRoute(context)
                  .navigateToChangePasswordView(widget.email);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF408cff).withOpacity(0.7)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 30.0, // Set the size here
            ),
            // Replace with your icon
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 120, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Did not receive the email? ',
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: () {
                    // Handle resend action here
                    AuthAccountViewModel(context).forgotPassword(widget.email);
                  },
                  child: const Text('Resend.',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ))
      ]),
    );
  }
}
