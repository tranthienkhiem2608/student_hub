import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/views/homescreen/welcome_view.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:permission_handler/permission_handler.dart';

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
      home: FutureBuilder(
        // Request the camera permission when the app starts
        future: requestCameraPermission(),
        builder: (context, snapshot) {
          // Show the WelcomePage when permission is granted
          if (snapshot.connectionState == ConnectionState.done) {
            return WelcomePage();
          }
          // Show a loading spinner while waiting for permission
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }
}
