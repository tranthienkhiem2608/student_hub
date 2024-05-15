import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/view_models/auth_account_viewModel.dart';
import 'package:student_hub/views/homescreen/welcome_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), checkIfUserIsLoggedIn);
  }

  Future<void> checkIfUserIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      AuthAccountViewModel(context).getAuthMe();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                child: LottieBuilder.asset(
                    "assets/lottie/Animation - 1715775810912.json"),
              ),
              Text('Student Hub',
                  style: GoogleFonts.poppins(
                      fontSize: 25, color: Color(0xFF406AFF), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        nextScreen: const SplashScreen(),
        splashIconSize: 400,
        backgroundColor: Colors.white,
      ),
    );
  }
}
