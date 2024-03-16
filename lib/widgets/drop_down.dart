import 'package:flutter/material.dart';
import 'package:llm_chat/constants/constants.dart';

class ModelsDropDownWidge extends StatefulWidget {
  const ModelsDropDownWidge({super.key});

  @override
  State<ModelsDropDownWidge> createState() => _ModelsDropDownWidgeState();
}

class _ModelsDropDownWidgeState extends State<ModelsDropDownWidge> {
  String currentModels = "Model1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: scafoldBackgroundColor,
      iconEnabledColor: Colors.white,
      items: getModelsItem,
      value: currentModels,
      onChanged: (value) {
        setState(() {
          currentModels = value.toString();
        });
      },
    );
  }
}
