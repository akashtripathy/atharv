import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:atharv/pages/dashboard.dart';
import 'package:atharv/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  Widget page = const WelcomePage();

  bool? isLoggedin = prefs.getBool("isloggedIn") == null ? false : true;

  if (prefs.containsKey("uId") && isLoggedin) {
    page = const DashBoardPage();
  }
  runApp(MyApp(page: page));
}

class MyApp extends StatelessWidget {
  final Widget page;
  const MyApp({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Atharv',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Icons.home,
            nextScreen: page,
            splashTransition: SplashTransition.slideTransition,
            pageTransitionType: PageTransitionType.leftToRight,
            backgroundColor: Colors.blue));
  }
}
