import 'package:atharv/pages/Hub.dart';
import 'package:atharv/pages/report_card.dart';
import 'package:flutter/material.dart';

class ShowFullListPage extends StatefulWidget {
  final String title;
  const ShowFullListPage({
    super.key,
    required this.title,
  });

  @override
  State<ShowFullListPage> createState() => _ShowFullListPageState();
}

class _ShowFullListPageState extends State<ShowFullListPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleSpacing: 0,
        backgroundColor: Colors.blue[300],
        elevation: 0,
      ),
      body: widget.title == "Profiles List"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    width: size.width,
                    height: size.height - 100,
                    child: ListView.separated(
                      itemCount: 40,
                      separatorBuilder: (context, int int) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width - 80,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              decoration: BoxDecoration(
                                  color: Colors.teal[100],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.black54, width: 2)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        border: Border.all(
                                            color: Colors.black54, width: 1),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "images/images.png"))),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  const HubPage(
                                                      "Update Profile")));
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
                )
              ],
            )
          : SingleChildScrollView(
              child: Container(
                height: size.height,
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.only(bottom: 120, top: 20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    for (var i = 0; i < 10; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 25),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Date : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Hospital : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Doctor : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Diagnose : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
