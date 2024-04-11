import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_hub/view_models/auth_account_viewModel.dart';

class ChangePasswordView extends StatefulWidget {
  final String email;
  const ChangePasswordView(this.email, {super.key});
  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
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

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ValueNotifier<String> oldPasswordNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> newPasswordNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> confirmPasswordNotifier =
      ValueNotifier<String>('');
  bool _obscurePassword = true;
  bool _showPassError = false; // Flag to control error visibility
// Start with the password hidden

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      backgroundColor: Color(0xFFF2F5FC), // Set the background color here
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: // Replace with your image
                    Text(
                  "Create new password",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Set the color here
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Your new password must be different from previous used password.",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black.withOpacity(0.7), // Set the color here
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 5.0, left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextField(
              onChanged: (value) => oldPasswordNotifier.value =
                  value, // Update oldPasswordNotifier when text changes
              obscureText: _obscurePassword, // Use the visibility variable
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                hintText: 'Enter your old password',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
                prefixIcon: const Icon(
                  Iconsax.key,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // Toggle visibility
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5.0, left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "New Password",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextField(
              onChanged: (value) {
                newPasswordNotifier.value = value;
                setState(() {
                  _showPassError = false; // Reset error on change
                });
              }, // Update oldPasswordNotifier when text changes
              obscureText: _obscurePassword, // Use the visibility variable
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                errorText: _showPassError ? 'Both password must match' : null,
                errorStyle: const TextStyle(color: Colors.red),
                focusedErrorBorder: OutlineInputBorder(
                  // Change this
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Enter your new password',
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
                  Iconsax.key,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // Toggle visibility
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5.0, left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Confirm Password",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextField(
              onChanged: (value) {
                confirmPasswordNotifier.value = value;
                setState(() {
                  _showPassError = false; // Reset error on change
                });
              }, // Update oldPasswordNotifier when text changes
              obscureText: _obscurePassword, // Use the visibility variable
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                errorText: _showPassError ? 'Both password must match' : null,
                errorStyle: const TextStyle(color: Colors.red),
                focusedErrorBorder: OutlineInputBorder(
                  // Change this
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Confirm your new password',
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
                  Iconsax.key,
                  color: Colors.black,
                  size: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // Toggle visibility
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 400,
                height: 50,
                child: MaterialButton(
                  onPressed: oldPasswordNotifier.value.isNotEmpty &&
                          newPasswordNotifier.value.isNotEmpty &&
                          confirmPasswordNotifier.value.isNotEmpty
                      ? () async {
                          if (newPasswordNotifier.value !=
                              confirmPasswordNotifier.value) {
                            setState(() {
                              _showPassError = true; // Show error in TextField
                            });
                            return;
                          }
                          AuthAccountViewModel(context).changePassword(
                              widget.email,
                              oldPasswordNotifier.value,
                              newPasswordNotifier.value);
                        }
                      : null,
                  color: Color(0xFF408cff).withOpacity(0.7),
                  disabledColor: Colors.grey.shade500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  child: Text(
                    "Reset password",
                    style: TextStyle(
                        color: Colors.black.withOpacity(1), fontSize: 16.0),
                  ),
                  // Replace with your icon
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
