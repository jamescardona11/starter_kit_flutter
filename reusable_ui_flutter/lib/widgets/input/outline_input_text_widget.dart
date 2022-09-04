import 'package:flutter/material.dart';

class OutlineTextInput extends StatelessWidget {
  const OutlineTextInput({
    Key? key,
    required this.label,
    this.background = const Color(0xfff5f5f5),
    this.leadingIcon,
    this.iconColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.cursorColor,
    this.borderRadius = 10,
    this.obscureText = false,
    this.onChanged,
    this.style,
  }) : super(key: key);

  final String label;
  final Color background;
  final IconData? leadingIcon;
  final Color iconColor;
  final Color borderColor;
  final Color? cursorColor;
  final double borderRadius;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background,
      child: TextFormField(
        obscureText: obscureText,
        cursorColor: cursorColor,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: style ??
              const TextStyle(
                fontSize: 15,
                color: Colors.black38,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          prefixIcon: Icon(
            leadingIcon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
