import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/role/role%20add/addButtonClicked_diolougeBox/dialougeBox.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/role/role%20add/role%20Listing/roleListView.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class RoleAddpage extends StatefulWidget {
  final String addRole1;
  const RoleAddpage({super.key, required this.addRole1});

  @override
  State<RoleAddpage> createState() => _RoleAddpageState();
}

class _RoleAddpageState extends State<RoleAddpage> {
  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
      backgroundColor: Color(0xFFEFFBFB),
      appBar: AppBar(
         backgroundColor: Color(0xFFEFFBFB),
        title: Text('ADD ROLES',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color(0xFF57CFCE)),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF57CFCE),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialougebox(
                  addRole1: widget.addRole1,
                );
              });
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Rolelistview(),
    );
  }
}
