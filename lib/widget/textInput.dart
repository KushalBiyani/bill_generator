import 'package:flutter/material.dart';

class TextInputLabel extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool type; //true for text, false for number
  TextInputLabel(this.controller, this.label, this.type);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type ? TextInputType.name : TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
