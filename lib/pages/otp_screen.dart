import 'package:atharv/pages/create_account.dart';
import 'package:atharv/widgets/custom_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class OtpVarificationPage extends StatefulWidget {
  final String verificationId;
  const OtpVarificationPage({super.key, required this.verificationId});

  @override
  State<OtpVarificationPage> createState() => _OtpVarificationPageState();
}

class _OtpVarificationPageState extends State<OtpVarificationPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 100,
        msg: 'Please wait...',
        progressBgColor: Colors.black,
        backgroundColor: Colors.white);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print(userCredential);
      // User successfully signed in
      pd.close();
      // You can navigate to the next screen or perform necessary actions
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CreateAccountPage(userCredential: userCredential),
        ),
      );
      print('User signed in: ${userCredential.user!.uid}');
    } catch (e) {
      // Handle sign-in errors (e.g., incorrect OTP)
      print('Sign-in error: $e');
      // You might want to show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: CustomPaint(
          painter: MyCustomPainter("Sign"),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        height: size.height / 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "OTP Verify",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    height: size.height - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          child: OtpTextField(
                            numberOfFields: 6,
                            borderColor: const Color(0xFF512DA8),
                            //set to true to show as box or false to show as dash
                            showFieldAsBox: true,
                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              //handle validation or checks here
                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) async {
                              await signInWithPhoneNumber(
                                  widget.verificationId, verificationCode);

                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return AlertDialog(
                              //         title: const Text("Verification Code"),
                              //         content: Text(
                              //             'Code entered is $verificationCode'),
                              //         actions: [
                              //           TextButton(
                              //               onPressed: () {
                              //                 Navigator.push(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                         builder: (BuildContext
                              //                                 context) =>
                              //                             const DashBoardPage()));
                              //               },
                              //               child: const Text("Ok"))
                              //         ],
                              //       );
                              //     });
                            }, // end onSubmit
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
