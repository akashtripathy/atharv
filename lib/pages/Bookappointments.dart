import 'package:firstproject/widgets/Cpaint.dart';
import 'package:flutter/material.dart';


String doctorValue = "";
String hospitalValue = "";
String memberValue = "";

var fieldLIst = [
  "Select Doctor",
  "Select Hospital",
  "Select Member",
  "Choose Date",
  "Choose Time",
];

var fieldLIst2 = [
  "Select Hospital",
  "Select Doctor",
  "Select Member",
  "Choose Date",
  "Choose Time",
];
var doctorLIst = [
  'Doctor 1',
  'Doctor 2',
  'Doctor 3',
  'Doctor 4',
  'Doctor 5',
];

var memberLIst = [
  'Member 1',
  'Member 2',
  'Member 3',
  'Member 4',
  'Member 5',
];

var hospitalLIst = [
  'Hospital 1',
  'Hospital 2',
  'Hospital 3',
  'Hospital 4',
  'Hospital 5',
];

bool isByDoctor = true;
bool isByHospital = false;

class bookAppointments extends StatefulWidget {
  const bookAppointments({super.key, this.restorationId});
  final String? restorationId;

  @override
  State<bookAppointments> createState() => _bookAppointmentsState();
}

class _bookAppointmentsState extends State<bookAppointments>

    // this is for calender ............
    with
        RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  // main body ..........

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          isByDoctor ? Colors.greenAccent.shade100 : Colors.teal[100],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height / 5,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: const Text(
                          "Book Appointments",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isByHospital = false;
                                          isByDoctor = true;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                            color: isByDoctor
                                                ? Colors.blue[300]
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Text("Search by Doctor"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isByDoctor = false;
                                          isByHospital = true;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                            color: isByHospital
                                                ? Colors.blue[300]
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Text("Search by Hospital"),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: size.width,
                                  height: size.height * 0.45,
                                  child: ListView.separated(
                                      itemCount: isByDoctor
                                          ? fieldLIst.length
                                          : fieldLIst2.length,
                                      separatorBuilder: (context, int) {
                                        return const Divider();
                                      },
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: size.width,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(isByDoctor
                                                  ? fieldLIst[index]
                                                  : fieldLIst2[index]),
                                              SizedBox(
                                                width: size.width * 0.25,
                                                child: Text(
                                                  fieldLIst[index] ==
                                                          "Choose Date"
                                                      ? ' ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'
                                                      : fieldLIst[index] ==
                                                              "Choose Time"
                                                          ? "20:35"
                                                          : fieldLIst[index] ==
                                                                  "Select Doctor"
                                                              ? doctorValue
                                                              : fieldLIst[index] ==
                                                                      "Select Hospital"
                                                                  ? hospitalValue
                                                                  : memberValue,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              fieldLIst[index] == "Choose Date"
                                                  ? IconButton(
                                                      onPressed: () {
                                                        _restorableDatePickerRouteFuture
                                                            .present();
                                                      },
                                                      icon: const Icon(
                                                          Icons.date_range))
                                                  : fieldLIst[index] ==
                                                          "Choose Time"
                                                      ? IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(Icons
                                                              .watch_later_outlined))
                                                      : IconButton(
                                                          onPressed: () {
                                                            isByDoctor
                                                                ? myBottomSheet(
                                                                    size,
                                                                    fieldLIst[
                                                                        index])
                                                                : myBottomSheet(
                                                                    size,
                                                                    fieldLIst2[
                                                                        index]);
                                                          },
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down)
                                                          // doctorLIst: myBottomSheet(size),
                                                          )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  width: size.width * 0.5,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Colors.blue[300], elevation: 0, // foreground
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        )),
                                    child: const Text(
                                      "Book",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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

  // modal bottomsheet ............

  Future<void> myBottomSheet(size, fieldType) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: fieldType == "Select Doctor"
                    ? doctorLIst.length
                    : fieldType == "Select Hospital"
                        ? hospitalLIst.length
                        : fieldType == "Select Member"
                            ? memberLIst.length
                            : 0,
                separatorBuilder: (context, int) {
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
                            fieldType == "Select Doctor"
                                ? doctorLIst[index]
                                : fieldType == "Select Hospital"
                                    ? hospitalLIst[index]
                                    : fieldType == "Select Member"
                                        ? memberLIst[index]
                                        : "Ram",
                          )),
                      onTap: () {
                        setState(() {
                          fieldType == "Select Doctor"
                              ? doctorValue = doctorLIst[index].toString()
                              : fieldType == "Select Hospital"
                                  ? hospitalValue = hospitalLIst[index]
                                  : memberValue = memberLIst[index];
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
