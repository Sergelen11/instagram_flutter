import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/commentsscreen.dart';
import 'package:instagram/screens/main_screen.dart';
import 'package:instagram/screens/useraccountscreen.dart';
import 'package:instagram/screens/viewpostscreen.dart';
import 'package:instagram/utils/routes.dart';
import 'package:instagram/screens/login.dart';
import 'package:instagram/screens/signup.dart';
import 'package:instagram/screens/splashscreen.dart';
// import './random_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const int _blackPrimaryValue = 0xFF000000;
  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(primarySwatch: primaryBlack),
        initialRoute: userAccountRoute,
        routes: <String, WidgetBuilder>{
          splashRoute: (context) => const SplashScreen(),
          loginRoute: (context) => const LoginScreen(),
          signUpRoute: (context) => const SignUpScreen(),
          mainRoute: (context) => const MainScreen(),
          viewpostRoute: (context) => const ViewPostScreen(),
          userAccountRoute: (context) => const UserAccountScreen(),
          commentRoute: (context) => const CommentsScreen(),
        });
  }
}
