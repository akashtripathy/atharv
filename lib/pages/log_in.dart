// ignore_for_file: non_constant_identifier_names
import 'package:atharv/pages/dashboard.dart';
import 'package:atharv/pages/phone_number_screen.dart';
import 'package:atharv/widgets/custom_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var phoneNoController = TextEditingController();
  var passController = TextEditingController();
  late ProgressDialog pd;
  Future<void> Login() async {
    pd = ProgressDialog(context: context);
    if (_formKey.currentState!.validate()) {
      if (phoneNoController.text.length < 10) {
        _showMyDialog("Contact number should be of 10 digits!");
      } else if (passController.text.length < 8) {
        _showMyDialog("Password should be 0f minimum 8 digit!");
      } else {
        pd.show(
            max: 100,
            msg: 'Please wait...',
            progressBgColor: Colors.black,
            backgroundColor: Colors.white);
        await signInWithPhoneAndPassword(
            phoneNoController.text, passController.text);
        // pd.close();
        // if (!mounted) return;
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const DashBoardPage()));
      }
    }
  }

  Future<void> _showMyDialog(alertTitle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alertTitle),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> signInWithPhoneAndPassword(
    String phoneNumber,
    String password,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Find the user by their phone number in Firestore
      QuerySnapshot users = await firestore
          .collection('patients')
          .where('phone_number', isEqualTo: "+91$phoneNumber")
          .limit(1)
          .get();

      if (users.docs.isNotEmpty) {
        // If a user with the specified phone number is found
        DocumentSnapshot userDoc = users.docs.first;
        String storedPassword = userDoc['password'];

        print("User: ${userDoc.id}");
        print(storedPassword);

        // Compare the entered password with the stored password
        if (password == storedPassword) {
          // Sign in the user with their phone number
          // ConfirmationResult authResult =
          // await auth.verifyPhoneNumber("+91$phoneNumber");

          //Setting up shared preference for storing small datas
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("isloggedIn", true);
          prefs.setString("uId", userDoc.id);
          // prefs.setString("verificationId", authResult.verificationId);

          // print(
          //     'User authenticated with phone number: ${authResult.verificationId}');

          pd.close();
          if (!mounted) return;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashBoardPage()));
        } else {
          pd.close();
          _showMyDialog("Incorrect Credential!");
        }
      } else {
        pd.close();
        _showMyDialog('User not found with the specified phone number');
      }
    } catch (e) {
      pd.close();
      print('Error during phone authentication: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();

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
              leading: const Center(),
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
                              "Login",
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          child: Form(
                            key: _formKey,
                            child: Column(
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
                                  controller: phoneNoController,
                                  maxLength: 10,
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
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    return null;
                                  },
                                  controller: passController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    filled: true,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "Password",
                                    fillColor: Colors.grey.shade100,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Login();
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
                                      "Login",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account ? ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PhoneNumberScreen()));
                                        },
                                        child: const Text("SignUp"))
                                  ],
                                )
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
