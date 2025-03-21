import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_details/assistant_detailsPage.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_updatetextfields/assistant_equipment_update.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_updatetextfields/assistant_update__custom_button.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_updatetextfields/assistant_update_place_textfield.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_updatetextfields/assitant_update_name_textfield.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_updatetextfields/assitant_update_phone_textfield.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/no_roles_given_text_check.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/role/role%20add/dropdown_menu/role_drop_downmenu.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';
import 'package:phototickapp/db/assistants_function/db_function.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';
import 'package:phototickapp/db/role_function/role_function.dart';

class AssistantsShowScreen extends StatefulWidget {
  final List<AssistantModel> assistants;

  AssistantsShowScreen({super.key, required this.assistants});

  @override
  State<AssistantsShowScreen> createState() => _AssistantsShowScreenState();
}

class _AssistantsShowScreenState extends State<AssistantsShowScreen> {
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updatePhoneController = TextEditingController();
  TextEditingController updatePlaceController = TextEditingController();
  TextEditingController updateEquipmentController = TextEditingController();

  ValueNotifier<List<RoleModel>> selectedRoles =
      ValueNotifier<List<RoleModel>>([]);

  void handleItemSelection(String roleId) {
    setState(() {
      final roleToAdd =
          roleListNotifier.value.firstWhere((role) => role.id == roleId);
      if (selectedRoles.value.any((role) => role.id == roleId)) {
        selectedRoles.value = [...selectedRoles.value]
          ..removeWhere((role) => role.id == roleId);
      } else {
        selectedRoles.value = [...selectedRoles.value, roleToAdd];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:backgroundColor,
      body: ValueListenableBuilder(
        valueListenable: assistantListNotifier,
        builder: (BuildContext context, List<AssistantModel> assistants,
            Widget? child) {
          if (assistants.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add_disabled_rounded,
                    color: grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No Assistant Added',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: assistants.length,
            itemBuilder: (context, index) {
              final assistant = assistants[index];

              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: Card(
                  shadowColor: backgroundColor,
                  elevation: 0,
                  color:white,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Assistantdetailspage(
                            assistantDetailsShow: assistant);
                      }));
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('imagesforapp/07c4720d19a9e9edad9d0e939eca304a.jpg'),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return bottomSheetUpdate(context, assistant);
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color:editColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDeleteAlert(context, assistant.id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: deleteColor,
                          ),
                        ),
                      ],
                    ),
                    title: Text(assistant.name),
                    subtitle: no_roles_given_text_check(assistant: assistant),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget bottomSheetUpdate(BuildContext context, AssistantModel assistant) {
    updateNameController.text = assistant.name;
    updatePhoneController.text = assistant.Phone;
    updatePlaceController.text = assistant.Place;
    updateEquipmentController.text = assistant.equipment;

    selectedRoles.value = List.from(assistant.selectedroles);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            assitant_updateName_textfield(
                updateNameController: updateNameController),
            assitant_updatePhone_textfield(
                updatePhoneController: updatePhoneController),
            assistant_updatePlace_textfield(
                updatePlaceController: updatePlaceController),
                assistant_updateEquipment_textfield(updateEquipmentController: updateEquipmentController),
              
            ValueListenableBuilder<List<RoleModel>>(
              valueListenable: selectedRoles,
              builder: (context, selected, child) {
                return roleFilterChips(
                  allRoleList: roleListNotifier.value,
                  selectedItems: selected,
                  onItemSelected: handleItemSelection,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: InkWell(
                onTap: () {
                  onUpdateButtonClicked(context, assistant.id);
                  Navigator.pop(context);
                },
                child: assistant_update_CustomButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onUpdateButtonClicked(
      BuildContext context, String assistantId) async {
    final _updateName = updateNameController.text.trim();
    final _updatePhone = updatePhoneController.text.trim();
    final _updatePlace = updatePlaceController.text.trim();
    final _updateEquipment = updateEquipmentController.text.trim();

    if (_updateName.isEmpty || _updatePhone.isEmpty || _updatePlace.isEmpty) {
      return;
    }

    final _updateAssistant = AssistantModel(
      selectedroles: selectedRoles.value,
      id: assistantId,
      name: _updateName,
      Phone: _updatePhone,
      Place: _updatePlace,
      equipment: _updateEquipment,
    );

    await updateAssistant(_updateAssistant);
  }

  Future<void> showDeleteAlert(BuildContext context, String id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Confirmation',style: TextStyle(color:appBarColor),),
            content: Text('Are you sure to delete ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  deleteAssistant(id);
                  Navigator.pop(context);
                  gettAllAssistant();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Assisitant Was Deleted')),
                  );
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
