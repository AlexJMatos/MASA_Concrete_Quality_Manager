import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLength;
  final String validatorText;
  final bool readOnly;

  const CustomNumberFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.maxLength = 5,
      this.readOnly = false,
      required this.validatorText});

  const CustomNumberFormField.withDefault(
      {super.key,
      required this.controller,
      required this.labelText,
      this.maxLength = 10,
      required this.readOnly,
      this.validatorText = ""});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: maxLength,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
