// import 'package:flutter/material.dart';
// import 'package:phototickapp/Screens/customwidget/textfield.dart';
// import 'package:phototickapp/Screens/homescreen/customButton/customButton.dart';
// import 'package:phototickapp/Screens/todo%20list/todoList.dart';
// import 'package:phototickapp/db/clientFunction/dbClientFunction.dart';

// class Clientdeatailsupdatepage extends StatefulWidget {
//   final String date;
//   final String time;
//   final String name;
//   final String location;
//   final String event;
//   final String phone;
//   final String budget;
//   const Clientdeatailsupdatepage(
//       {super.key,
//       required this.date,
//       required this.time,
//       required this.name,
//       required this.location,
//       required this.event,
//       required this.phone,
//       required this.budget});

//   @override
//   State<Clientdeatailsupdatepage> createState() =>
//       _ClientdeatailsupdatepageState();
// }

// class _ClientdeatailsupdatepageState extends State<Clientdeatailsupdatepage> {
//   TextEditingController _updateDateController = TextEditingController();
//   TextEditingController _updateTimeController = TextEditingController();
//   TextEditingController _updateNameController = TextEditingController();
//   TextEditingController _updateLocationController = TextEditingController();
//   TextEditingController _updateEventController = TextEditingController();
//   TextEditingController _updatePhoneController = TextEditingController();
//   TextEditingController _updateBudgetController = TextEditingController();

//   late Size mediaSize;
//   @override
//   Widget build(BuildContext context) {
//     mediaSize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Color(0xFFF2F4F3),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF2F4F3),
//         centerTitle: true,
//         title: Text('Add Client Details'),
//       ),
//       body: SafeArea(
//         child: Container(
//           height: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                         child: Padding(
//                       padding: const EdgeInsets.only(left: 20, top: 25),
//                       child: TextField(
//                         keyboardType: TextInputType.datetime,
//                         controller: _updateDateController,
//                         // onTap: _selectDate,
//                         decoration: InputDecoration(
//                             fillColor: const Color.fromARGB(255, 211, 211, 211),
//                             filled: true,
//                             hintText: 'Date',
//                             suffixIcon: Icon(Icons.date_range_outlined),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(9),
//                               borderSide: BorderSide.none,
//                             )),
//                       ),
//                     )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                         child: Padding(
//                       padding: const EdgeInsets.only(right: 20, top: 25),
//                       child: TextField(
//                         keyboardType: TextInputType.datetime,
//                         controller: _updateTimeController,
//                         // onTap: _selectTime,
//                         decoration: InputDecoration(
//                             fillColor: const Color.fromARGB(255, 211, 211, 211),
//                             filled: true,
//                             hintText: 'Time',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(9),
//                               borderSide: BorderSide.none,
//                             )),
//                       ),
//                     )),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
//                   child: CustomTextfield(
//                     hintText: 'Name',
//                     controller: _updateNameController,
//                     keybordTpe: TextInputType.name,
//                     color1: const Color.fromARGB(255, 211, 211, 211),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
//                   child: CustomTextfield(
//                     hintText: 'Location',
//                     controller: _updateLocationController,
//                     keybordTpe: TextInputType.streetAddress,
//                     color1: const Color.fromARGB(255, 211, 211, 211),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
//                   child: CustomTextfield(
//                     hintText: 'Event',
//                     controller: _updateEventController,
//                     keybordTpe: TextInputType.text,
//                     color1: const Color.fromARGB(255, 211, 211, 211),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
//                   child: CustomTextfield(
//                     hintText: 'Phone',
//                     controller: _updatePhoneController,
//                     keybordTpe: TextInputType.phone,
//                     color1: const Color.fromARGB(255, 211, 211, 211),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
//                   child: CustomTextfield(
//                     hintText: 'Budget',
//                     controller: _updateBudgetController,
//                     keybordTpe: TextInputType.number,
//                     color1: const Color.fromARGB(255, 211, 211, 211),
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(top: 25),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 20),
//                           child: InkWell(
//                             onTap: () {
//                               // addClientSaveButtonClicked();

//                               Navigator.pop(context);
//                               getAllClients();
//                             },
//                             child: Custombutton(
//                               textColor: Colors.white,
//                               backgroundColor: Color(0xFF7D9A8A),
//                               text: 'Save',
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 20),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.of(context)
//                                   .push(MaterialPageRoute(builder: (context) {
//                                 return Todolist();
//                               }));
//                             },
//                             child: Custombutton(
//                               textColor: Colors.white,
//                               backgroundColor: Color(0xFF7D9A8A),
//                               text: 'To-Do',
//                             ),
//                           ),
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//      Future <void> onClientUpdateButtonClicked(BuildContext context , String clientId) async{

//     final _updateName = _updateDateController.text.trim();
//     final _updatePhone = updatePhoneController.text.trim();
//     final _updatePlace = updatePlaceController.text.trim();
//     final _updateRole = updateRoleController.text.trim();
//     if(_updateName.isEmpty || _updatePhone.isEmpty || _updatePlace.isEmpty || _updateRole.isEmpty){
//       return;
//     }

//     final _updateAssistant = AssistantModel(id :assistantId, name: _updateName, Phone: _updatePhone, Place: _updatePlace, role: _updateRole, );
//    await updateAssistant(_updateAssistant);

//   }
// }
