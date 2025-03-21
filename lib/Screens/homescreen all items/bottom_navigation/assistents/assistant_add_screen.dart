import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/assistant_show_screen.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/role/role%20add/dropdown_menu/role_drop_downmenu.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/assistents/role/role%20add/role_addpage.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';
import 'package:phototickapp/db/assistants_function/db_function.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';
import 'package:phototickapp/db/role_function/role_function.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class AssistantsAddScreen extends StatefulWidget {
  const AssistantsAddScreen({super.key});

  @override
  State<AssistantsAddScreen> createState() => _AssistantsscreenState();
}

class _AssistantsscreenState extends State<AssistantsAddScreen> {
  ValueNotifier<List<RoleModel>> selectedRoles = ValueNotifier<List<RoleModel>>([]);

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _placeController = TextEditingController();
  final _equipmentController = TextEditingController();

  void handleItemSelection(String roleId) {
    final roleToAdd = roleListNotifier.value.firstWhere((role) => role.id == roleId);

    if (selectedRoles.value.any((role) => role.id == roleId)) {
      selectedRoles.value = [...selectedRoles.value]..removeWhere((role) => role.id == roleId);
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
      backgroundColor:backgroundColor,
      appBar: AppBar(
        backgroundColor:appBarColor,
        centerTitle: true,
        title: Text(
          'ASSISTANTS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color:white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appBarColor,
        foregroundColor:white,
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
          // Input Fields with Icons
          TextFieldWithIcon(
            controller: _nameController,
            hintText: 'Assistant Name',
            icon: Icons.person,
          ),
          TextFieldWithIcon(
            controller: _phoneController,
            hintText: 'Assistant Phone',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          TextFieldWithIcon(
            controller: _placeController,
            hintText: 'Assistant Place',
            icon: Icons.place,
          ),
           TextFieldWithIcon(
            controller: _equipmentController,
            hintText: 'Assistant Equipments',
            icon: Icons.camera,
          ),

          // Role Selection
          Column(
            children: [
              Text(
                'ROLES',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey),
              ),
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

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.trim().isNotEmpty &&
                        _phoneController.text.trim().isNotEmpty &&
                        _placeController.text.trim().isNotEmpty &&
                        selectedRoles.value.isNotEmpty) {
                      onAddAssistantButtonClicked();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all the fields.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:appBarColor, // Background color
                  ),
                  child: Text('Add Assistant',style: TextStyle(color: white),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return RoleAddpage(addRole1: '');
                      },
                    ));
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: appBarColor),
                  ),
                  child: Text('Add Role'),
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
    final _equipment = _equipmentController.text.trim();

    if (_name.isEmpty || _phone.isEmpty || _place.isEmpty || selectedRoles.value.isEmpty) {
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
      equipment: _equipment,
    );

    await addAssistant(_assistant);

    _nameController.clear();
    _phoneController.clear();
    _placeController.clear();
    _equipmentController.clear();
    selectedRoles.value = [];
    selectedRoles.notifyListeners();
  }
}

// Widget for TextField with Icon
class TextFieldWithIcon extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;

  const TextFieldWithIcon({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color:appBarColor),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: appBarColor),
          ),
        ),
      ),
    );
  }
}