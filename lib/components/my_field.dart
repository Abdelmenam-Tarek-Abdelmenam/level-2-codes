import 'package:flutter/material.dart';

class MyFiled extends StatelessWidget {
  const MyFiled(
      {required this.controller,
      required this.label,
      required this.icon,
      required this.validatorText,
      this.suffixIcon,
      Key? key})
      : super(key: key);
  final TextEditingController controller;
  final String validatorText;
  final String label;
  final IconData icon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? validatorText : null,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          suffixIcon: suffixIcon,
          label: Text(label),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
          focusedBorder: const OutlineInputBorder()),
    );
  }
}
