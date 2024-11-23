import 'package:flutter/material.dart';

import '../../../styles/colors.dart';

class NameField extends StatelessWidget {
  final TextEditingController nameController;
  final FocusNode node;
  final ValueChanged<String> onChanged;

  const NameField({
    Key? key,
    required this.nameController,
    required this.node,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
      focusNode: node,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: "Name",
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainGreen,
            width: 2.0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainGreen,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
