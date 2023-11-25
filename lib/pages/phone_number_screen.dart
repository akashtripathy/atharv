import 'package:atharv/pages/otp_screen.dart';
import 'package:atharv/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  var phoneNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _verifyPhoneNumber() async {
    ProgressDialog pd = ProgressDialog(context: context);
    FirebaseAuth auth = FirebaseAuth.instance;

    final String phoneNumber =
        '+91${phoneNoController.text}'; // Modify the country code as needed

    pd.show(
        max: 100,
        msg: 'Sending OTP...',
        progressBgColor: Colors.black,
        backgroundColor: Colors.white);
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // This callback will be invoked for instant verification (auto-retrieval of SMS code)
        // You can add code to handle instant verification here.
      },
      verificationFailed: (FirebaseAuthException e) {
        pd.close();
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Phone number is not valid")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Something went wrong!")));
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // Navigate to OTP screen and pass verificationId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpVarificationPage(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // This callback will be invoked after a timeout and can be used to show a button for manual code input.
        // You can add code for a manual code input option here.
      },
    );
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
                              "Phone No.",
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
                  child: SizedBox(
                    width: size.width,
                    height: size.height - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height / 2,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone no';
                                    }
                                    return null;
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    counterText: '',
                                    filled: true,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "Phone No.",
                                    fillColor: Colors.grey.shade100,
                                  ),
                                  controller: phoneNoController,
                                  maxLength: 10,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                SizedBox(
                                  width: size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await _verifyPhoneNumber();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Colors.blue[300], // foreground
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        )),
                                    child: const Text(
                                      "Send OTP",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
