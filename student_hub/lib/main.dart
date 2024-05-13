import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/views/homescreen/welcome_view.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  bool isDarkMode = await addAuthorizationToSocket();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: ChangeNotifierProvider(
        create: (_) => DarkModeProvider(isDarkMode: isDarkMode),
        child: MyApp(),
      ),
    ),
  );
}

Future<bool> addAuthorizationToSocket() async {
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.containsKey('isDarkMode') ? prefs.getBool('isDarkMode')! : false;
  print("Darkmode: $isDarkMode");
  return isDarkMode;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
