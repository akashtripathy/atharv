import 'package:firstproject/widgets/Cpaint.dart';
import 'package:flutter/material.dart';

Color myBlue = Colors.blue[300]!;

class ReportCardPage extends StatefulWidget {
  const ReportCardPage({super.key});

  @override
  State<ReportCardPage> createState() => _ReportCardPageState();
}

class _ReportCardPageState extends State<ReportCardPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: CustomPaint(
            painter: MyCustomPainter("Report Card"),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text(
                  "Health Reports",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                backgroundColor: Colors.transparent,
                titleSpacing: 0,
                leading: const BackButton(
                  color: Colors.blue,
                ),
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
                      icon: const Icon(
                        Icons.power_settings_new_rounded,
                      ))
                ],
                elevation: 0,
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black87, backgroundColor: Colors.grey.shade200, elevation: 0, // foreground
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                        child: const Text(
                          "Download",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: size.width - 145,
                              height: 100,
                              child: const Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("ID : "),
                                      Text("Name : "),
                                      Text("Age : "),
                                      Text("Blood Group : ")
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [Text("Gender : ")],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black54),
                                  borderRadius: BorderRadius.circular(200),
                                  image: const DecorationImage(
                                      image: AssetImage("images/images.png"))),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          height: 100,
                          color: Colors.blue[300],
                          width: size.width,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Hospital :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Doctor :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "Diagnose :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.3,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 11,
                            separatorBuilder: (context, int) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: size.width * 0.5,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://static.vecteezy.com/system/resources/previews/000/330/222/original/vector-report-icon.jpg"))),
                              );
                            },
                          ),
                        ),
                      ],
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
