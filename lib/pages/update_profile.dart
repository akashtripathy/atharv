import 'package:flutter/material.dart';

String genderValue = "";
String bloodGroupValue = "";
String blockValue = "";
String districtValue = "";

var fieldLIst = [
  "ID",
  "Name",
  "Age",
  "Select Gender",
  "Select Blood Group",
  "Select District",
  "Select Block",
  "Address :",
];

var genderList = [
  'Male',
  'Female',
  'Other',
];

var blockList = [
  'Block 1',
  'Block 2',
  'Block 3',
  'Block 4',
  'Block 5',
];

var districtList = [
  'District 1',
  'District 2',
  'District 3',
  'District 4',
  'District 5',
];

var bloodGroupList = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black54),
                borderRadius: BorderRadius.circular(200),
                image: const DecorationImage(
                    image: AssetImage("images/images.png"))),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: size.height * 0.5,
            child: ListView.separated(
                itemCount: fieldLIst.length,
                separatorBuilder: (context, int int) {
                  return const SizedBox(
                    height: 3,
                  );
                },
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.topLeft,
                    width: size.width,
                    height: fieldLIst[index] == "Address :" ? 100 : null,
                    padding: fieldLIst[index] == "Select Gender" ||
                            fieldLIst[index] == "Select Blood Group" ||
                            fieldLIst[index] == "Select District" ||
                            fieldLIst[index] == "Select Block"
                        ? const EdgeInsets.symmetric(horizontal: 15)
                        : const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          fieldLIst[index],
                        ),
                        SizedBox(
                          width: size.width * 0.25,
                          child: fieldLIst[index] == "Select Gender" ||
                                  fieldLIst[index] == "Select Blood Group" ||
                                  fieldLIst[index] == "Select District" ||
                                  fieldLIst[index] == "Select Block"
                              ? Text(
                                  fieldLIst[index] == "Select Gender"
                                      ? genderValue
                                      : fieldLIst[index] == "Select Blood Group"
                                          ? bloodGroupValue
                                          : fieldLIst[index] ==
                                                  "Select District"
                                              ? districtValue
                                              : blockValue,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )
                              : SizedBox(
                                  width: size.width * 0.5,
                                  height: 40,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type Your Value',
                                    ),
                                  )),
                        ),
                        fieldLIst[index] == "Select Gender" ||
                                fieldLIst[index] == "Select Blood Group" ||
                                fieldLIst[index] == "Select District" ||
                                fieldLIst[index] == "Select Block"
                            ? IconButton(
                                onPressed: () {
                                  myBottomSheet(size, fieldLIst[index]);
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 15,
                                )
                                // genderList: myBottomSheet(size),
                                )
                            : const SizedBox()
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: size.width * 0.30,
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
                "Update",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<void> myBottomSheet(size, fieldType) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: fieldType == "Select Gender"
                    ? genderList.length
                    : fieldType == "Select Blood Group"
                        ? bloodGroupList.length
                        : fieldType == "Select District"
                            ? districtList.length
                            : blockList.length,
                separatorBuilder: (context, int int) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                          width: size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15),
                          color: Colors.grey.shade50,
                          child: Text(
                            fieldType == "Select Gender"
                                ? genderList[index]
                                : fieldType == "Select Blood Group"
                                    ? bloodGroupList[index]
                                    : fieldType == "Select District"
                                        ? districtList[index]
                                        : blockList[index],
                          )),
                      onTap: () {
                        setState(() {
                          fieldType == "Select Gender"
                              ? genderValue = genderList[index].toString()
                              : fieldType == "Select Blood Group"
                                  ? bloodGroupValue = bloodGroupList[index]
                                  : fieldType == "Select District"
                                      ? districtValue = districtList[index]
                                      : blockValue = blockList[index];
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
