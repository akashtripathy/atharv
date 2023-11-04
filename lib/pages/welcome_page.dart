import 'package:atharv/pages/phone_number_screen.dart';
import 'package:atharv/pages/sign_in.dart';
import 'package:atharv/pages/sign_up.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.blue[300],
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text("Logo"),
          Container(
            child: Column(
              children: [
                SizedBox(
                  width: size.width - 50,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black, // foreground
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    child: const Text(
                      "Log In",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: size.width - 50,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhoneNumberScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black, // foreground
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
