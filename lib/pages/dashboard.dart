import 'package:atharv/pages/book_appointments.dart';
import 'package:atharv/pages/find_doctor.dart';
import 'package:atharv/pages/health_report.dart';
import 'package:atharv/pages/my_bookings.dart';
import 'package:atharv/pages/profile.dart';
import 'package:atharv/pages/welcome_page.dart';
import 'package:atharv/widgets/custom_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final Map<String, dynamic> pageList = {
    "Book Appointment": const BookAppointments(),
    "My Bookings": const MyBookingsPage(),
    "Find Hospital": const FindDoctorPage(),
    "Find doctor": const FindDoctorPage(),
    "Profiles": const ProfilesPage(),
    "Health Records": const HealthReports()
  };

  // Function to log out the current user and navigate to the login screen
  Future<void> signOutAndNavigateToLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    await prefs.clear();
    // Navigate to the login screen
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  Future<void> getPatientData(String uid) async {
    try {
      // Get a reference to the "patients" collection
      CollectionReference patientsCollection =
          FirebaseFirestore.instance.collection('patients');

      // Get the document with the specified UID
      DocumentSnapshot patientDocument =
          await patientsCollection.doc(uid).get();

      if (patientDocument.exists) {
        // Access data from the document
        Map<String, dynamic> patientData =
            patientDocument.data()! as Map<String, dynamic>;
        print('Patient data: $patientData');
      } else {
        print('No patient found with UID: $uid');
      }
    } catch (e) {
      print('Error fetching patient data: $e');
    }
  }

  // Perform asynchronous operations before updating the state
  void asyncOperations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("uId"));
    await getPatientData(prefs.getString("uId")!);
    // Other asynchronous operations...
  }

  @override
  void initState() {
    asyncOperations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          height: size.height,
          width: size.width,
          child: CustomPaint(
            painter: MyCustomPainter("Dash"),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
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
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  signOutAndNavigateToLogin(context);
                                },
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
              body: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height / 5,
                    decoration: const BoxDecoration(
                        // color: Colors.lightBlueAccent,
                        ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: size.height - 278,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                        ),
                        itemCount: pageList.length,
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          final List<String> pageKeys = pageList.keys.toList();
                          final List<dynamic> pageValues =
                              pageList.values.toList();
                          final dynamic pageValue = pageValues[index];
                          final String pageKey = pageKeys[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pageValue));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.teal[100],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                pageKey,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
