import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/role/role%20add/role_addPage.dart';



class customIconButton extends StatelessWidget {
  const customIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return RoleAddpage(addRole1: '');
      }));
    }, child: Icon(Icons.add,size: 30,color: Colors.black,));
  }
}