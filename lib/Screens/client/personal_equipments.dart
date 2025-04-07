import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/functions_repositaries/equipment_repositery.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class PersonalEquipments extends StatefulWidget {
  final ClientModel clientid;
  final List<String>? equipment;

  PersonalEquipments({required this.clientid, super.key, this.equipment});

  @override
  State<PersonalEquipments> createState() => _PersonalEquipmentsState();
}

class _PersonalEquipmentsState extends State<PersonalEquipments> {
  List<String> equipmentList = [];
  final EquipmentRepository equipmentRepository =
      EquipmentRepository(); // Create an instance of EquipmentRepository

  @override
  void initState() {
    super.initState();
    fetchEquipments();
    if (widget.equipment != null) {
      setState(() {
        equipmentList = widget.equipment!;
      });
    }
  }

  Future<void> fetchEquipments() async {
    ClientModel? client =
        await equipmentRepository.getClient(widget.clientid.id);
    if (client != null && client.personalEquipments != null) {
      setState(() {
        equipmentList = client.personalEquipments!;
      });
    } else {
      print('No equipments found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Equipments',
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold, color: white)),
        backgroundColor: appBarColor,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogToAddEquipment();
        },
        child: Icon(Icons.add),
        backgroundColor: appBarColor,
        foregroundColor: white,
      ),
      body: ListView.builder(
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              width: double.infinity,
              height: 50,
              color: white,
              child: ListTile(
                title: Text(equipmentList[index]),
                trailing: IconButton(
                  onPressed: () {
                    _showDeleteEquipmentDialog(index);
                  },
                  icon: Icon(Icons.delete, color: deleteColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> showDialogToAddEquipment() async {
    TextEditingController equipmentController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Equipment'),
          content: TextField(
            controller: equipmentController,
            decoration: InputDecoration(hintText: 'Enter Equipment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (equipmentController.text.isNotEmpty) {
                  setState(() {
                    equipmentList.add(equipmentController.text);
                  });
                  await equipmentRepository.saveEquipments(
                      widget.clientid.id, equipmentList);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteEquipmentDialog(int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Are you sure you want to delete this equipment?'),
          title:
              Text('Delete Equipment?', style: TextStyle(color: appBarColor)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                String equipment = equipmentList[index];
                await equipmentRepository.deleteEquipment(
                    widget.clientid.id, equipment);
                setState(() {
                  equipmentList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Yes', style: TextStyle(color: deleteColor)),
            ),
          ],
        );
      },
    );
  }
}
