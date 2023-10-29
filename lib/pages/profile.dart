import 'package:atharv/pages/full_list.dart';
import 'package:atharv/pages/hub.dart';
import 'package:atharv/pages/report_card.dart';
import 'package:flutter/material.dart';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: size.width - 30,
            height: size.height * 0.5,
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (context, int int) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(
                      width: size.width - 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
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
                                border:
                                    Border.all(color: Colors.black54, width: 1),
                                image: const DecorationImage(
                                    image: AssetImage("images/images.png"))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text("Name : "),
                              ),
                              SizedBox(
                                width: 80,
                                child: Text("ID : "),
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "Age :  ",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Blood Group :  ",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
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
                                          const HubPage("Update Profile")));
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
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ShowFullListPage(
                              title: "Profiles List",
                            )));
              },
              child: const Text(
                "View All...",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: size.width * 0.4,
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
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.4,
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
                  style: TextStyle(fontSize: 17),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
