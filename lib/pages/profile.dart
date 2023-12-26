import 'package:atharv/pages/Hub.dart';
import 'package:atharv/pages/report_card.dart';
import 'package:atharv/pages/update_profile.dart';
import 'package:atharv/widgets/custom_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  String uId = 'null';
  // Perform asynchronous operations before updating the state
  void asyncOperations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString("uId")!;
    setState(() {});
  }

  @override
  void initState() {
    asyncOperations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        titleSpacing: 0,
        elevation: 0,
      ),
      body: CustomPaint(
        painter: MyCustomPainter("Profile"), // Change the type as needed
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height / 5,
                    decoration: const BoxDecoration(
                        // color: Colors.lightBlueAccent,
                        ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          textAlign: TextAlign.center,
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
                  Column(
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          width: size.width - 30,
                          height: size.height,
                          child: uId == 'null'
                              ? const SizedBox()
                              : buildFirestoreStream(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: size.width * 0.45,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HubPage("Add Member")));
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlueAccent, // foreground
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                child: const Text(
                  "Add Member",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.45,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlueAccent, // foreground
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                child: const Text(
                  "Delete Member",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFirestoreStream() {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('patients')
          .doc(
              uId) // Replace 'specific_document_id' with the actual ID of the document you want
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Display a loading indicator while fetching data
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Check if there are no documents
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No documents available'));
        }

        // Build the UI using the data from the QuerySnapshot
        return ListView.separated(
          itemCount: 1,
          separatorBuilder: (context, int int) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!;
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Row(
              children: [
                Container(
                  width: size.width - 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black54, width: 2)),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(color: Colors.black54, width: 1),
                            image: const DecorationImage(
                                image: AssetImage("images/images.png"))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: 120,
                            height: 20,
                            child: Text("Name : ${data['name']}"),
                          ),
                          SizedBox(
                            // width: 80,
                            height: 20,
                            child: Text("ID : ${data['atharv_id']}"),
                          ),
                          SizedBox(
                            // width: 80,
                            height: 20,
                            child: Text(
                              "Age : ${data['dob']} ",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 20,
                            // width: 100,
                            child: Text(
                              "Blood Group : ${data['blood_group']} ",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UpdateProfilePage(
                                        data: data,
                                      )));
                        },
                        icon: Image.asset(
                          "images/edit doc.png",
                          height: 20,
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ReportCardPage()));
                        },
                        icon: Image.asset(
                          "images/add doc.png",
                          height: 20,
                        )),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
