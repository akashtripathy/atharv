// // import 'package:flutter/material.dart';
// //
// // /// Flutter code sample for [DropdownButton].
// //
// // // const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
// //
// // class DropdownButtonExample extends StatefulWidget {
// //   List<String> list = <String>[];
// //   DropdownButtonExample({required this.list});
// //
// //   @override
// //   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// // }
// //
// // class _DropdownButtonExampleState extends State<DropdownButtonExample> {
// //   @override
// //   Widget build(BuildContext context) {
// //     String dropdownValue = widget.list.first;
// //     return DropdownButton<String>(
// //       value: dropdownValue,
// //       icon: const Icon(Icons.arrow_drop_down_sharp),
// //       elevation: 0,
// //       underline: Transform.translate(offset: Offset(0, 0)),
// //       style: const TextStyle(color: Colors.black54),
// //       onChanged: (String? value) {
// //         // This is called when the user selects an item.
// //         setState(() {
// //           dropdownValue = value!;
// //         });
// //       },
// //       items: widget.list.map<DropdownMenuItem<String>>((String value) {
// //         return DropdownMenuItem<String>(
// //           value: value,
// //           child: Text(value),
// //         );
// //       }).toList(),
// //     );
// //   }
// // }
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class MySelections extends StatefulWidget {
//   const MySelections({Key? key}) : super(key: key);
//
//   @override
//   _MySelectionsState createState() => _MySelectionsState();
// }
//
// class _MySelectionsState extends State<MySelections> {
//   String selectValue = "";
//   List categoryItemlist = [];
//
//   //List categoryItemlist = List();  //it is not working
//
//   // ***********************************************************
//   // Fetch data from JSON/API File
//   // Future getAllCategory() async {
//   //   var baseUrl = "https://gssskhokhar.com/api/classes/";
//   //
//   //   http.Response response = await http.get(Uri.parse(baseUrl));
//   //
//   //   if (response.statusCode == 200) {
//   //     var jsonData = json.decode(response.body);
//   //     setState(() {
//   //       categoryItemlist = jsonData;
//   //     });
//   //   }
//   //   print(categoryItemlist);
//   // }
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getAllCategory();
//   // }
//   // ***********************************************************
//
// // Initial Selected Value
//   String dropdownvalue = 'Item 1';
//
// // List of items in our dropdown menu
//   var items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButton(
//               // Initial Value
//               value: dropdownvalue,
//
//               // Down Arrow Icon
//               icon: const Icon(Icons.keyboard_arrow_down),
//
//               // Array list of items
//               items: items.map((String items) {
//                 return DropdownMenuItem(
//                   value: items,
//                   child: Text(items),
//                 );
//               }).toList(),
//               // After selecting the desired option,it will
//               // change button value to selected value
//               onChanged: (String? newValue) {
//                 setState(() {
//                   dropdownvalue = newValue!;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

/// Flutter code sample for [showDatePicker].
class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerExampleState extends State<DatePickerExample>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('Open Date Picker'),
        ),
      ),
    );
  }
}
