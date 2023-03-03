import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(this.onPressed, this.label, {this.color, Key? key})
      : super(key: key);
  final Function() onPressed;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
        ));
  }
}
