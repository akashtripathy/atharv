import 'package:atharv/pages/add_member.dart';
import 'package:atharv/pages/health_report.dart';
import 'package:atharv/pages/my_bookings.dart';
import 'package:atharv/pages/profile.dart';
import 'package:atharv/pages/update_profile.dart';
import 'package:atharv/widgets/custom_layout.dart';
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
                          style: const TextStyle(
                              color: Colors.black, fontSize: 30),
                        )
                      : const SizedBox(),
                  titleSpacing: 0,
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
                              ? const MyBookingsPage()
                              : widget.testText == "Profiles"
                                  ? const ProfilesPage()
                                  : widget.testText == "Update Profile"
                                      ? const ProfilesPage()
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
