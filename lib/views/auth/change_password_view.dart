import 'package:easy_localization/easy_localization.dart';
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
      backgroundColor: Colors.white, // Set the background color here
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 5.0),
              child: Align(
                alignment: Alignment.center,
                child: // Replace with your image
                    Text(
                  "changepassword_auth1".tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF406AFF), // Set the color here
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
                  "changepassword_auth2".tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black.withOpacity(0.5), // Set the color here
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 5.0, left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "changepassword_auth3".tr(),
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
              cursorColor: Color(0xFF406AFF),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
                hintText: 'changepassword_auth4'.tr(),
                hintStyle: GoogleFonts.poppins(
                  color: Color(0xFF777B8A),
                  fontSize: 14.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF4BEC0C7), width: 0.8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF4BEC0C7), width: 1),
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
              // Remove the duplicate obscureText argument
              // Remove this line: obscureText: true,
              style: GoogleFonts.poppins(
                color: Colors.black, // Màu của văn bản ẩn
                fontSize: 14.0, // Cỡ chữ của văn bản ẩn
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5.0, left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "changepassword_auth5".tr(),
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
              cursorColor: Color(0xFF406AFF),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
                errorText: _showPassError ? 'changepassword_auth6'.tr() : null,
                errorStyle: GoogleFonts.poppins(color: Colors.red),
                focusedErrorBorder: OutlineInputBorder(
                  // Change this
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'changepassword_auth7'.tr(),
                hintStyle: GoogleFonts.poppins(
                  color: Color(0xFF777B8A),
                  fontSize: 14.0,
                ),
                labelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF4BEC0C7), width: 0.8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF4BEC0C7), width: 1),
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
              style: GoogleFonts.poppins(
                color: Colors.black, // Màu của văn bản ẩn
                fontSize: 14.0, // Cỡ chữ của văn bản ẩn
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5.0, left: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "changepassword_auth8".tr(),
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
              cursorColor: Color(0xFF406AFF),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
                errorText: _showPassError ? 'Both password must match' : null,
                errorStyle: GoogleFonts.poppins(color: Colors.red),
                focusedErrorBorder: OutlineInputBorder(
                  // Change this
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'changepassword_auth9'.tr(),
                hintStyle: GoogleFonts.poppins(
                  color: Color(0xFF777B8A),
                  fontSize: 14.0,
                ),
                labelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF4BEC0C7), width: 0.8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF4BEC0C7), width: 1),
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
              style: GoogleFonts.poppins(
                color: Colors.black, // Màu của văn bản ẩn
                fontSize: 15.0, // Cỡ chữ của văn bản ẩn
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
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
                  color: Color(0xFF406AFF),
                  disabledColor: Colors.grey.shade500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  child: Text(
                    "changepassword_auth10".tr(),
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 16.0),
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
