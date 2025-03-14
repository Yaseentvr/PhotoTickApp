// import 'package:flutter/material.dart';
// import 'package:phototickapp/screen%20Sizes/screenSize.dart';

// // ignore: must_be_immutable
// class Todolist extends StatefulWidget {
//   TextEditingController todoNote = TextEditingController();

//   Todolist({
//     super.key,
//   });

//   @override
//   State<Todolist> createState() => _TodolistState();
// }

// class _TodolistState extends State<Todolist> {
//   late Size mediaSize;
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     Screensize();
//     return Scaffold(
//       backgroundColor: Color(0xFFEFFBFB),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFEFFBFB),
//         centerTitle: true,
//         title: Text('To-Do-List'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialogToDoListAdd(context);
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Color(0xFF57CFCE),
//         foregroundColor: Colors.white,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   Future<void> showDialogToDoListAdd(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           final TextEditingController TodoListController =
//               TextEditingController();
//           return AlertDialog(
//             content: Form(
//               key: _formKey,
//               child: TextFormField(
//                 controller: TodoListController,
//                 decoration: InputDecoration(
//                   labelText: 'Add To Do',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter ';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('Cancel')),
//               TextButton(
//                   onPressed: () {
                    
//                     Navigator.pop(context);
//                   },
//                   child: Text('Save')),
//             ],
//           );
//         });
//   }

//   // Future<void> ToDosaveButton()async{

//   // }
// }
