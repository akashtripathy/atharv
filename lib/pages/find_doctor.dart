import 'package:atharv/widgets/custom_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindDoctorPage extends StatefulWidget {
  const FindDoctorPage({super.key});

  @override
  State<FindDoctorPage> createState() => _FindDoctorPageState();
}

class _FindDoctorPageState extends State<FindDoctorPage> {
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
        painter: MyCustomPainter(""), // Change the type as needed
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
                          "Find Doctor",
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
                  SingleChildScrollView(
                      child: SizedBox(
                    width: size.width - 30,
                    height: size.height * 0.5,
                    child: getDoctorStream(),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDoctorStream() {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .snapshots(), // Use .snapshots() to listen for changes in the collection
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Check if there are no documents
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No documents available'));
        }
        // Build the UI using the data from the QuerySnapshot
        return ListView.separated(
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, int int) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                        child: Text(
                            "Name : ${data['first_name']} ${data['last_name']}"),
                      ),
                      SizedBox(
                        // width: 80,
                        height: 20,
                        child: Text("ID : ${data['d_id']}"),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            // width: 80,
                            // height: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Specialists: "),
                                Row(
                                  children: List<Widget>.generate(
                                    data['specialist'].length,
                                    (int i) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(data['specialist'][i]),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          // SizedBox(
                          //   height: 20,
                          //   // width: 100,
                          //   child: Text(
                          //     "Blood Group : ${data['blood_group']} ",
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
