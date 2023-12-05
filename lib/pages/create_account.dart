import 'package:atharv/pages/log_in.dart';
import 'package:atharv/widgets/custom_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class CreateAccountPage extends StatefulWidget {
  final UserCredential userCredential;
  const CreateAccountPage({super.key, required this.userCredential});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  var nameCotroller = TextEditingController();
  var phoneNoController = TextEditingController();
  var passController = TextEditingController();
  var confPassCotroller = TextEditingController();

  Future<void> signUp() async {
    ProgressDialog pd = ProgressDialog(context: context);
    if (_formKey.currentState!.validate()) {
      if (phoneNoController.text.length < 10) {
        _showMyDialog(
            "Your contact number should be of 10 digits, but it's ${phoneNoController.text.length}");
      } else if (passController.text.length < 8) {
        _showMyDialog("Password must be of 8 charaters!");
      } else if (nameCotroller.text.isEmpty) {
        _showMyDialog("Name field is empty!");
      } else if (passController.text != confPassCotroller.text) {
        _showMyDialog("Confirm Password Did Not Match!");
      } else {
        pd.show(
            max: 100,
            msg: 'Please wait...',
            progressBgColor: Colors.black,
            backgroundColor: Colors.white);
        await saveUserData();
      }
    }
  }

  Future<void> _showMyDialog(alertTitle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$alertTitle'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$alertTitle'),
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

  Future<void> saveUserData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = widget.userCredential.user!.uid;
    String? phone = widget.userCredential.user!.phoneNumber;
    ProgressDialog pd = ProgressDialog(context: context);
    try {
      // Create patient data in Firestore
      await firestore.collection('patients').doc(uid).set({
        'type': 'primary',
        'atharv_id': null,
        'phone_number': phone.toString(),
        'name': nameCotroller.text.toString(),
        'password': passController.text.toString(),
        'dob': null,
        'blood_group': null,
        'district': null,
        'block': null,
        'address': null,
        'profile_pic': null,
        'created_at': DateTime.now(),
      });
      pd.close();
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignInPage()));
    } catch (e) {
      _showMyDialog("Something went wrong");
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    phoneNoController.text = widget.userCredential.user!.phoneNumber!;

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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Create",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              "account",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            )
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
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                  controller: nameCotroller,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    filled: true,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "Name",
                                    fillColor: Colors.grey.shade100,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter phonne no';
                                    }
                                    return null;
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  controller: phoneNoController,
                                  maxLength: 10,
                                  enabled: false,
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
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter confirm password';
                                    }
                                    return null;
                                  },
                                  controller: confPassCotroller,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 2)),
                                    filled: true,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[800]),
                                    hintText: "Confirm Password",
                                    fillColor: Colors.grey.shade100,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width: size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      signUp();
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
                                      "Submit",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
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
