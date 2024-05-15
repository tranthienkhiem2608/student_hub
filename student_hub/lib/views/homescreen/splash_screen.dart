import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
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
                width: 200,
                height: 200,
                child: LottieBuilder.asset(
                    "assets/lottie/Animation - 1715721976074.json"),
              ),
              const Text('Student Hub',
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 12, 220, 235))),
            ],
          ),
        ),
        nextScreen: const SplashScreen(),
        splashIconSize: 400,
        backgroundColor: const Color(0xFF69cde0).withOpacity(0.5),
      ),
    );
  }
}
