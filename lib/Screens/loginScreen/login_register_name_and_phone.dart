import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/splashScreens/secondsplash.dart';
import 'package:phototickapp/custom/customButton/customButton.dart';
import 'package:phototickapp/custom/customwidget/textfield.dart';
import 'package:phototickapp/db/assistants_function/db_function.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/login_Function/loginFunction.dart';
import 'package:phototickapp/db/login_model/loginModel.dart';

class loginRegisterNameAndPhone extends StatelessWidget {
  final ClientModel clientCheck;
  const loginRegisterNameAndPhone({
    super.key,
    required TextEditingController loginNameController,
    required TextEditingController loginPhoneController, required this.clientCheck,
  }) : _loginNameController = loginNameController, _loginPhoneController = loginPhoneController;

  final TextEditingController _loginNameController;
  final TextEditingController _loginPhoneController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 10, bottom: 20),
            child: Column(
              children: [
                Text(
                  'Please Enter Your Details ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  color1: Colors.white,
                  hintText: 'Company Name',
                  controller: _loginNameController,
                  keybordTpe: TextInputType.name,
                   keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  color1: Colors.white,
                  hintText: 'Company Number',
                  controller: _loginPhoneController,
                  keybordTpe: TextInputType.number,
                   keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      String name = _loginNameController.text;
                      String phone = _loginPhoneController.text;
    
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return Secondsplash(name: name, phone: phone,clientCheck: clientCheck,);
                      }));
    
                      final user = Loginmodel(
                        id: randomId(),
                        loginName: _loginNameController.text,
                        loginPhone: _loginPhoneController.text,
                      );
                      addLoginDetail(user);
                    },
                    child: Custombutton(
                        textColor: Colors.white,
                        backgroundColor: Color(0xFF7D9A8A),
                        text: 'Save',)),
              ],
            )),
      ),
    );
  }
}
