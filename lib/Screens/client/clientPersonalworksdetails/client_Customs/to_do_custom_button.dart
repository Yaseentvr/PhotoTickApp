// import 'package:flutter/material.dart';
// import 'package:phototickapp/Screens/todo%20list/todoList.dart';
// import 'package:phototickapp/custom/customButton/customButton.dart';

// class ToDoCustomButton extends StatelessWidget {
//   final String? clientId;
//   const ToDoCustomButton({
//     super.key, this.clientId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20),
//       child: InkWell(
//         onTap: () {
//           if(clientId != null){
//              Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) {
//             return Todolist();
//           }));
//           }
         
//         },
//         child: Custombutton(
//           textColor: Colors.white,
//           backgroundColor: Color(0xFF57CFCE),
//           text: 'To-Do',
//         ),
//       ),
//     );
//   }
// }
