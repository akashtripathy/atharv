import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:atharv/pages/sign_up.dart';
import 'package:atharv/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Atharv',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Icons.home,
            // nextScreen: const SignUpPage(),
            nextScreen: const WelcomePage(),
            splashTransition: SplashTransition.slideTransition,
            pageTransitionType: PageTransitionType.leftToRight,
            backgroundColor: Colors.blue));
  }
}
