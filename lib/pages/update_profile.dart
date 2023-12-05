import 'package:atharv/widgets/custom_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  final Map<String, dynamic> data;
  const UpdateProfilePage({super.key, required this.data});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String genderValue = "Gender";
  String bloodGroupValue = "Blood Group";
  String blockValue = "Block";
  String districtValue = "District";

  final TextEditingController _id = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _block = TextEditingController();
  final TextEditingController _address = TextEditingController();

  var genderList = [
    'Male',
    'Female',
    'Other',
  ];
  var blockList = ['Bargarh', 'Attabira', 'Bijepur', 'Bheden'];
  var districtList = ['Bargarh', 'Sambalpur'];
  var bloodGroupList = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  void updateDocument() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String? documentId = prefs.getString('uId');
    // Specify the updates you want to apply
    Map<String, dynamic> updates = {
      'name': _name.text,
      'dob': _dob.text,
      'gender': _gender.text,
      'blood_group': _bloodGroup.text,
      'block': _block.text,
      'district': _district.text,
      'address': _address.text,
    };

    print(documentId);
    // Update the document with the specified ID
    try {
      await firestore.collection("patients").doc(documentId).update(updates);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updated successfully!')),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _id.text = widget.data['atharv_id'];
    _name.text = widget.data['name'];
    _dob.text = widget.data['dob'] == null ? "" : widget.data['dob'];
    _bloodGroup.text =
        widget.data['blood_group'] == null ? "" : widget.data['blood_group'];
    _district.text =
        widget.data['district'] == null ? "" : widget.data['district'];
    _block.text = widget.data['block'] == null ? "" : widget.data['block'];
    _address.text =
        widget.data['address'] == null ? "" : widget.data['address'];
    _gender.text = widget.data['gender'] == null ? "" : widget.data['gender'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: MyCustomPainter(""),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: const BackButton(),
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Update Profile",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: size.width / 2,
                  child: Center(
                    child: Container(
                      width: size.width / 4.5,
                      height: size.width / 4.5,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                              image: AssetImage("images/images.png"))),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width - 50,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _id,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Id should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(Icons
                                  .assignment_ind), // Your desired prefix icon
                              hintText: 'ID',
                              prefixText: 'ID: ',

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                                // No border on the sides
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            controller: _name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(Icons
                                  .person_outline), // Your desired prefix icon
                              hintText: 'Name',
                              prefixText: 'Name: ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide.none, // No border on the sides
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            controller: _dob,
                            onTap: () => myBottomSheet(size, "DOB"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'DOB should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(Icons
                                  .date_range_outlined), // Your desired prefix icon
                              hintText: 'DD/MM/YYYY',
                              prefixText: 'DOB: ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide.none, // No border on the sides
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            controller: _gender,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Gender should not be empty';
                              }
                              return null;
                            },
                            onTap: () => myBottomSheet(size, "Gender"),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(Icons
                                  .accessibility), // Your desired prefix icon
                              hintText: 'Gender',
                              prefixText: 'Gender: ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide.none, // No border on the sides
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // gender
                          TextFormField(
                            controller: _bloodGroup,
                            onTap: () => myBottomSheet(size, "Blood Group"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Blood group should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(
                                  Icons.bloodtype), // Your desired prefix icon
                              hintText: 'Blood Group',
                              prefixText: 'Blood Group: ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide.none, // No border on the sides
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          // blood group
                          TextFormField(
                            controller: _district,
                            onTap: () => myBottomSheet(size, "District"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(
                                  Icons.add_home), // Your desired prefix icon
                              hintText: 'District',
                              prefixText: 'District: ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide.none, // No border on the sides
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // district
                          TextFormField(
                            controller: _block,
                            onTap: () => myBottomSheet(size, "Block"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(
                                  Icons.add_home), // Your desired prefix icon
                              hintText: 'Block',
                              prefixText: 'Block: ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide.none, // No border on the sides
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // block
                          TextFormField(
                            controller: _address,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address should not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Adjust the color as needed
                              prefixIcon: const Icon(
                                  Icons.add_home), // Your desired prefix icon
                              hintText: 'Address',
                              prefixText: 'Address: ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide.none, // No border on the sides
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: size.width,
            color: Colors.transparent,
            height: 70,
            alignment: Alignment.center,
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    updateDocument();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                child: const Text("Update"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> myBottomSheet(size, fieldType) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            height: fieldType == "DOB" ? 300 : 200,
            alignment: Alignment.center,
            child: fieldType == "DOB"
                ? Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          maximumDate: DateTime.now(),
                          onDateTimeChanged: (DateTime picked) {
                            _dob.text = DateFormat('dd/MM/yyyy').format(picked);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Done'),
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    itemCount: fieldType == "Gender"
                        ? genderList.length
                        : fieldType == "Blood Group"
                            ? bloodGroupList.length
                            : fieldType == "District"
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
                                fieldType == "Gender"
                                    ? genderList[index]
                                    : fieldType == "Blood Group"
                                        ? bloodGroupList[index]
                                        : fieldType == "District"
                                            ? districtList[index]
                                            : blockList[index],
                              )),
                          onTap: () {
                            setState(() {
                              fieldType == "Gender"
                                  ? _gender.text = genderList[index].toString()
                                  : fieldType == "Blood Group"
                                      ? _bloodGroup.text = bloodGroupList[index]
                                      : fieldType == "District"
                                          ? _district.text = districtList[index]
                                          : _block.text = blockList[index];
                            });
                            Navigator.of(context).pop();
                          });
                    }),
          );
        });
  }
}
