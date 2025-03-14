import 'package:flutter/material.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';

class roleFilterChips extends StatelessWidget {
  final List<RoleModel> allRoleList;
  final List<RoleModel> selectedItems;
  final Function(String roleId) onItemSelected;

  const roleFilterChips({
    super.key,
    required this.allRoleList,
    required this.selectedItems,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: allRoleList.map((roleName) {
        return FilterChip(
          label: Text(
            roleName.role,
          ),
          selected: selectedItems
              .any((selectedItem) => selectedItem.id == roleName.id),
          onSelected: (isSelected) {
            onItemSelected(roleName.id);
          },
          selectedColor: Color(0xFF57CFCE),
          backgroundColor:Color(0xFFEFFBFB),
          checkmarkColor: Colors.white,
        );
      }).toList(),
    );
  }
}
