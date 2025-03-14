import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEquipments();
    if (widget.equipment != null) {
      setState(() {
        equipmentList = widget.equipment!;
      });
    }
  }

  Future<void> fetchEquipments()async{
    final box = await Hive.openBox<ClientModel>('Client_Box');
    ClientModel? client = box.get(widget.clientid.id);
    if(client != null && client.personalEquipments != null){
      setState(() {
        equipmentList = client.personalEquipments!;
      });
    }else{
      print('No equipments found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFFBFB),
      appBar: AppBar(
        
        title: Text('Equipments',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color(0xFF57CFCE)),),
       backgroundColor: Color(0xFFEFFBFB),
       centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogToAddEquipment();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: equipmentList.length,
        itemBuilder: (context,int){
        return Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
          child: Container(
            width: double.infinity,
            height: 50,
            color: Color(0xFFFFFFFF),
            child: ListTile(
              title: Text('${equipmentList[int]}'),
              trailing: IconButton(onPressed: (){
                deleteEquipment(widget.clientid.id,equipmentList[int] );
                
                
              }, icon: Icon(Icons.delete)),
            ),
          ),
        );
      }),

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
              onPressed: () async{
              if(equipmentController.text.isNotEmpty){
                setState(() {
                  equipmentList.add(equipmentController.text
                  );
                });
                await saveEquipments(widget.clientid.id, equipmentList);
                
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
  

  Future<void> saveEquipments(String clientId, List<String> equipments) async {
   final box = await Hive.openBox<ClientModel>('Client_Box');
   ClientModel? client = box.get(clientId);

   if(client != null){
      client.personalEquipments ??= [];
     client.personalEquipments = List.from(equipments);
     await box.put(clientId, client);

     print('Equipments added ${client.personalEquipments}');
   }else{
    print('Client not found');
   }
  }


  Future<void> deleteEquipment(String clientId, String equipment) async {
    setState(() {
      equipmentList.remove(equipment);
    });
    final box = await Hive.openBox<ClientModel>('Client_Box');
    ClientModel? client = box.get(clientId);

    if(client != null){
      client.personalEquipments?.remove(equipment);
      await box.put(clientId, client);
      print('Equipment deleted');
    }else{
      print('Client not found');
    }
  }
}
