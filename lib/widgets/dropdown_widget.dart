import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String hint;
  final List<String> items;

  DropdownWidget({required this.hint, required this.items});

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
      ),
      value: selectedValue,
      onChanged: (String? newValue) {
        selectedValue = newValue!;
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
