import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/assistantShowScreen.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/assitantAddTextFieldsFile/assistant_custom_add_button.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/assitantAddTextFieldsFile/assistant_name_text_field.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/assitantAddTextFieldsFile/assistant_phone_textfield.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/assitantAddTextFieldsFile/assistant_place_textfield.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/role/role%20add/add_role_custom_button.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/role/role%20add/dropdownMenu/roleDropDownMenu.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/assistents/role/role%20add/role_addPage.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';
import 'package:phototickapp/db/assistants_function/db_function.dart';
import 'package:phototickapp/db/role_Function/role_Function.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class AssistantsAddScreen extends StatefulWidget {
  const AssistantsAddScreen({super.key});

  @override
  State<AssistantsAddScreen> createState() => _AssistantsscreenState();
}

class _AssistantsscreenState extends State<AssistantsAddScreen> {
  ValueNotifier<List<RoleModel>> selectedRoles =
      ValueNotifier<List<RoleModel>>([]);

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _placeController = TextEditingController();

  void handleItemSelection(String roleId) {
    final roleToAdd =
        roleListNotifier.value.firstWhere((role) => role.id == roleId);

    if (selectedRoles.value.any((role) => role.id == roleId)) {
      selectedRoles.value = [...selectedRoles.value]
        ..removeWhere((role) => role.id == roleId);
    } else {
      selectedRoles.value = [...selectedRoles.value, roleToAdd];
    }

    selectedRoles.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    gettAllAssistant();
    Screensize();
    return Scaffold(
      backgroundColor: Color(0xFFEFFBFB),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFFBFB),
        centerTitle: true,
        title: Text(
          'ASSISTANTS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color: Color(0xFF57CFCE)),
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF57CFCE),
        foregroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return bottomSheet();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AssistantsShowScreen(
        assistants: [],
      ),
    );
  }

  Widget bottomSheet() {
    Screensize();
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          assistant_name_textField(nameController: _nameController),
          assistant_phone_textfield(phoneController: _phoneController),
          assistant_place_textfield(placeController: _placeController),
          
          Column(
            children: [
              Text('ROLES',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blueGrey),),
              ValueListenableBuilder<List<RoleModel>>(
                valueListenable: selectedRoles,
                builder: (context, selectedRolesList, child) {
                  return roleFilterChips(
                    allRoleList: roleListNotifier.value,
                    selectedItems: selectedRolesList,
                    onItemSelected: handleItemSelection,
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: InkWell(
                  onTap: () {
                    if (_nameController.text.trim().isNotEmpty &&
                        _phoneController.text.trim().isNotEmpty &&
                        _placeController.text.trim().isNotEmpty &&
                        selectedRoles.value.isNotEmpty) {
                      onAddAssistantButtonClicked();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill all the fields.')),
                      );
                    }
                  },
                  child: assistant_custom_add_button(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return RoleAddpage(addRole1: '');
                      },
                    ));
                  },
                  child: customIconButton(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onAddAssistantButtonClicked() async {
    final _name = _nameController.text.trim();
    final _phone = _phoneController.text.trim();
    final _place = _placeController.text.trim();

    if (_name.isEmpty ||
        _phone.isEmpty ||
        _place.isEmpty ||
        selectedRoles.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    String random = randomId();
    final _assistant = AssistantModel(
      name: _name,
      Phone: _phone,
      Place: _place,
      selectedroles: selectedRoles.value,
      id: random,
    );

    addAssistant(_assistant);

    _nameController.clear();
    _phoneController.clear();
    _placeController.clear();

    selectedRoles.value = [];
    selectedRoles.notifyListeners();
  }
}
