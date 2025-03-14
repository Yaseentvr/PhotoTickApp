import 'package:flutter/material.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';
import 'package:phototickapp/db/role_Function/role_Function.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Dialougebox extends StatefulWidget {
  final String addRole1;

  Dialougebox({
    super.key,
    required this.addRole1,
  });

  @override
  State<Dialougebox> createState() => _DialougeboxState();
}

class _DialougeboxState extends State<Dialougebox> {
  final _addRoleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Screensize();
    return AlertDialog(
      backgroundColor: Color(0xFFEFFBFB),
      content: Container(
        height: 130,
        child: Column(
          children: [
            CustomTextfield(
              hintText: 'Add Role',
              controller: _addRoleController,
              keybordTpe: TextInputType.text,
              color1: Color.fromARGB(223, 219, 219, 219),
               keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  onAddRoleButtonClicked();
                  // getAllRole();
                  Navigator.pop(context);
                },
                child: Text('Save',style: TextStyle(color: Colors.black),)),
          ],
        ),
      ),
    );
  }

  Future<void> onAddRoleButtonClicked() async {
    final _addRole = _addRoleController.text.trim();

    if (_addRole.isEmpty) {
      return;
    }

    String random1 = randomId1();
    final _addRoleHere = RoleModel(random1, role: _addRole);

    addRole(_addRoleHere);

    _addRoleController.clear();
  }
}
