import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';
import 'package:phototickapp/db/assistants_function/db_function.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/db/personal_assistant_model/personal_assistant_model.dart';

class PersonalAssistants extends StatefulWidget {
  final ClientModel clientId;

  const PersonalAssistants({Key? key, required this.clientId})
      : super(key: key);

  @override
  State<PersonalAssistants> createState() => _PersonalAssistantsState();
}

class _PersonalAssistantsState extends State<PersonalAssistants> {
  List<AssistantModel> allAssistants = [];
  List<PersonalAssistantModel> selectedAssistants = [];
  List<AssistantModel> tempSelected = [];

  @override
  void initState() {
    super.initState();
    _loadAssistants();
  }

  Future<void> _loadAssistants() async {
    await gettAllAssistant();
    setState(() {
      allAssistants = assistantListNotifier.value;
    });

    await _loadPersonalAssistantsFromHive();
  }

  Future<void> _loadPersonalAssistantsFromHive() async {
    final box = await Hive.openBox<ClientModel>('Client_Box');
    ClientModel? client = box.get(widget.clientId.id);

    if (client != null && client.personalAssistants != null) {
      setState(() {
        selectedAssistants =
            client.personalAssistants!.cast<PersonalAssistantModel>();
        tempSelected = selectedAssistants
            .map((selected) => allAssistants.firstWhere(
                  (assistant) => assistant.id == selected.assId,
                ))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEFF1), // Light grey-blue color
      appBar: AppBar(
        backgroundColor: const Color(0xFF57CFCE), // Teal color
        title: const Text(
          'Personal Assistants',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: selectedAssistants.isEmpty
          ? const Center(
              child: Text(
                'No assistants selected',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: selectedAssistants.length,
              itemBuilder: (context, index) {
                final assistant = selectedAssistants[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        assistant.assistantName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00796B), // Darker teal color
                        ),
                      ),
                      subtitle: Text(assistant.assistantPhone,
                          style: TextStyle(color: Colors.grey[600])),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF57CFCE),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateDialog) {
                  return AlertDialog(
                    title: const Text('Select Assistants'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: allAssistants.length,
                        itemBuilder: (context, index) {
                          final assistant = allAssistants[index];
                          final isSelected = tempSelected
                              .any((ass1) => ass1.id == assistant.id);
                          return CheckboxListTile(
                            title: Text(assistant.name),
                            subtitle: Text(assistant.Place),
                            value: isSelected,
                            onChanged: (bool? value) {
                              setStateDialog(() {
                                if (value == true) {
                                  tempSelected.add(assistant);
                                } else {
                                  tempSelected.removeWhere(
                                      (ass) => ass.id == assistant.id);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () async {
                          String clientId = widget.clientId.id;
                          await savePersonalAssistants(tempSelected, clientId);
                          await _loadPersonalAssistantsFromHive(); // Reload assistants
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Assistants have been saved!')),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> savePersonalAssistants(
      List<AssistantModel> assistants, String clientId) async {
    final box = await Hive.openBox<ClientModel>('Client_Box');
    List<PersonalAssistantModel> personalAssistants =
        assistants.map((assistant) {
      return PersonalAssistantModel(
        assId: assistant.id,
        assistantPhone: assistant.Phone,
        assistantName: assistant.name,
        clientId: clientId,
      );
    }).toList();

    ClientModel? client = box.get(clientId);
    if (client != null) {
      client.personalAssistants = personalAssistants;
      await box.put(clientId, client);
    }
  }
}
