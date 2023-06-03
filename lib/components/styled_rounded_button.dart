import 'package:flutter/material.dart';

class StyledRoundedButton extends StatelessWidget {
  const StyledRoundedButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.label,
  });

  final MaterialAccentColor color;
  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}