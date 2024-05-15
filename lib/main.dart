import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/services/notification_services.dart';
import 'package:student_hub/views/homescreen/error_screen.dart';
import 'package:student_hub/views/homescreen/splash_screen.dart';
import 'package:student_hub/views/homescreen/welcome_view.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalNotificationService.initialize(); // Add this line

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
  bool isDarkMode =
      prefs.containsKey('isDarkMode') ? prefs.getBool('isDarkMode')! : false;
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
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: checkInternetAndCameraPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return SplashScreen();
            } else {
              return ErrorScreen(); // Replace with your screen
            }
          }
          return SplashScreen();
        },
      ),
    );
  }

  Future<bool> checkInternetAndCameraPermission() async {
    // Check internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Check camera permission
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
      status = await Permission.camera.status;
      if (!status.isGranted) {
        return false;
      }
    }

    return true;
  }
}
