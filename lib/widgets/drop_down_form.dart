import 'package:doctr/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField(
      {Key? key,
      required this.items,
      required this.selectedValue,
      required this.onChanged})
      : super(key: key);
  final List<String> items;
  final String? selectedValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Select a symptom',
            labelStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          dropdownColor: primaryColor,
          style: const TextStyle(
            color: Colors.white,
          ),
          iconEnabledColor: Colors.white,
          value: selectedValue,
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    child: Text(item),
                    value: item,
                  ))
              .toList(),
          onChanged: onChanged),
    );
  }
}
