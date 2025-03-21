import 'package:flutter/material.dart';
import 'package:phototickapp/db/role_function/role_function.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';

class Rolelistview extends StatelessWidget {
  const Rolelistview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    getAllRole();
    return ValueListenableBuilder(
      valueListenable: roleListNotifier,
      builder: (BuildContext context, List<RoleModel> roleList, Widget? child) {
        if (roleList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.no_accounts_sharp,color: Colors.grey,),
                Text('No Roles',style: TextStyle(fontWeight: FontWeight.w300),),
              ],
            )
          );
        }
        return ListView.builder(
            itemCount: roleList.length,
            itemBuilder: (context, int) {
              final data = roleList[int];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    
                  },
                  title: Text(data.role),
                  trailing: IconButton(
                      onPressed: () {
                        showDeleteAlertRole(context, data.id);
                      },
                      icon: Icon(Icons.delete,color: Colors.redAccent,)),
                ),
              );
            });
      },
    );
  }

  Future<void> showDeleteAlertRole(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Confirmation'),
            content: Text('Are you sure to delete ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),
              TextButton(
                  onPressed: () {
                    deleteRole(id);
                    Navigator.pop(context);
                    getAllRole();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Role deleted')));

                  },
                  child: Text('Yes ')),
            ],
          );
        });
  }
}
