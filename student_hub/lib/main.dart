import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/views/homescreen/welcome_view.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DarkModeProvider(isDarkMode: addAuthorizationToSocket()),
      child: MyApp(),
    ),
  );
}

bool addAuthorizationToSocket() {
  SharedPreferences.getInstance().then((prefs) {
    bool isDarkMode =
        prefs.containsKey('isDarkMode') ? prefs.getBool('isDarkMode')! : false;
    print("Darkmode: $isDarkMode");

    return isDarkMode;
  });
  return false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Hub",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(),
    );
  }
}
