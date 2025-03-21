import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/expense%20add/personal_Budget_expenses.dart';
import 'package:phototickapp/Screens/client/personal_assistants.dart' as assistants;
import 'package:phototickapp/Screens/client/personal_equipments.dart';
import 'package:phototickapp/colors/colors.dart';
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
    return Center(
      child: Column(
        children: [
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(),
                  shadowColor: white,
                  elevation: 5,
                  backgroundColor: appBarColor,
                  foregroundColor: white,
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
                  style: TextStyle(fontSize: 20, color: white),
                ),
              ),
              SizedBox(
                width: 5,
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(),
                    shadowColor:white,
                    elevation: 5,
                    backgroundColor: appBarColor,
                    foregroundColor:white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PersonalEquipments(clientid: widget.clientDetailsClick,);
                    }));
                  },
                  child: Text(
                    'Equipment',
                    style: TextStyle(fontSize: 20, color:white),
                  )),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: white,
                    elevation: 5,
                    shape: BeveledRectangleBorder(),
                    backgroundColor:appBarColor,
                    foregroundColor: white,
                  ),
                  onPressed: () {
                    
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return assistants.PersonalAssistants(clientId:widget.clientDetailsClick ,);
                    }));
                  },
                  child: Text(
                    'assistants',
                    style: TextStyle(fontSize: 20, color:white),
                  )),
              SizedBox(
                width: 5,
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

 


}
