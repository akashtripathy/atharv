import 'package:firstproject/pages/Addmember.dart';
import 'package:firstproject/pages/Healthreport.dart';
import 'package:firstproject/pages/Mybookings.dart';
import 'package:firstproject/pages/Profiles.dart';
import 'package:firstproject/pages/Updateprofile.dart';
import 'package:firstproject/widgets/Cpaint.dart';
import 'package:flutter/material.dart';

class HubPage extends StatefulWidget {
  final String testText;
  const HubPage(this.testText, {super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: CustomPaint(
              painter: MyCustomPainter(""),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: widget.testText == "Update Profile" ||
                          widget.testText == "Add Member"
                      ? Text(
                          widget.testText,
                          style: const TextStyle(color: Colors.black, fontSize: 30),
                        )
                      : const SizedBox(),
                  titleSpacing: 0,
                  actions: [
                    IconButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Are You Sure!'),
                              content: const Text('Do you want to logout?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('LogOut'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.power_settings_new_rounded))
                  ],
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          widget.testText != "Update Profile" &&
                                  widget.testText != "Add Member"
                              ? Container(
                                  width: size.width,
                                  height: size.height / 5,
                                  decoration: const BoxDecoration(
                                      // color: Colors.lightBlueAccent,
                                      ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.testText,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.testText == "My Bookings"
                              ? const myBookingsPage()
                              : widget.testText == "Profiles"
                                  ? const ProfilesPage()
                                  : widget.testText == "Update Profile"
                                      ? const UpdateProfilePage()
                                      : widget.testText == "Add Member"
                                          ? const AddMemberPage()
                                          : widget.testText == "Health Records"
                                              ? const HealthReports()
                                              : const Center(
                                                  child: Text("nothing"),
                                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
