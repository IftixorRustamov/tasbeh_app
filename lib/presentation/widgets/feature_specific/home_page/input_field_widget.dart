import 'package:flutter/material.dart';
import 'package:tasbeh/config/theme/colors.dart';

class InputFieldReminder extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const InputFieldReminder(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputFieldColor = theme.brightness == Brightness.dark
        ? Colors.grey.shade800 // Dark theme background for input field
        : Colors.white; // Light theme background for input field
    final hintColor = theme.brightness == Brightness.dark
        ? Colors.grey // Dark theme hint text color
        : Colors.grey.shade600; // Light theme hint text color
    final textColor = theme.brightness == Brightness.dark
        ? Colors.white // Dark theme text color
        : MyColors.black; // Light theme text color
    final borderColor = theme.brightness == Brightness.dark
        ? Colors.grey.shade600 // Dark theme border color
        : Colors.grey.shade300; // Light theme border color
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: textColor, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: inputFieldColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
          style: TextStyle(color: textColor),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
