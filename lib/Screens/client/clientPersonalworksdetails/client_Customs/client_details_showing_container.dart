import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/expense%20add/personal_Budget_expenses.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/personal_assistants.dart' as assistants;
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/personal_equipments.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';
// import 'package:url_launcher/url_launcher.dart';

class clientDetailsShowing_container extends StatefulWidget {
  const clientDetailsShowing_container({
    super.key,
    required this.clientDetailsClick,
  });

  final ClientModel clientDetailsClick;

  @override
  State<clientDetailsShowing_container> createState() =>
      _clientDetailsShowing_containerState();
}

class _clientDetailsShowing_containerState
    extends State<clientDetailsShowing_container> {
  String? driveLink;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Screensize();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                shadowColor: Colors.white,
                elevation: 5,
                backgroundColor: Color(0xFF57CFCE),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return PersonalBudgetExpenses(
                    clientBudget1: widget.clientDetailsClick.budget,
                    clientId: widget.clientDetailsClick,
                  );
                }));
              },
              child: Text(
                'Budget',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 5,
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(),
                  shadowColor: Colors.white,
                  elevation: 5,
                  backgroundColor: Color(0xFF57CFCE),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PersonalEquipments(clientid: widget.clientDetailsClick,);
                  }));
                },
                child: Text(
                  'Equipment',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.white,
                  elevation: 5,
                  shape: BeveledRectangleBorder(),
                  backgroundColor: Color(0xFF57CFCE),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return assistants.PersonalAssistants(clientId:widget.clientDetailsClick ,);
                  }));
                },
                child: Text(
                  'assistants',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
            SizedBox(
              width: 5,
              height: 10,
            ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       shadowColor: Colors.white,
            //       elevation: 5,
            //       shape: BeveledRectangleBorder(),
            //       backgroundColor: Color(0xFF57CFCE),
            //       foregroundColor: Colors.white,
            //     ),
            //     onPressed: () {
            //       showDialogOfPhotosButtonCLicked(context);
            //     },
            //     child: Text(
            //       'Photos',
            //       style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            //     ),
          ],
        ),
      ],
    );
  }

  Future<void> showDialogOfPhotosButtonCLicked(BuildContext context) async {
    final TextEditingController textController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Drive Link'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Paste Drive Link',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a drive link';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    driveLink = textController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }


}
