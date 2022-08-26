import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    Key? key,
    required this.hint,
    required this.icon,
    this.width,
    this.iconColor,
    this.height,
    this.background,
    this.obscureText = false,
    this.isValid = false,
    this.onChanged,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String hint;
  final IconData icon;
  final Color? iconColor;
  final Color? background;
  final bool obscureText;
  final bool isValid;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(
          color: kGrayColorOpacity,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          icon: Icon(
            icon,
            color: isValid ? kBlueColor : kGrayColorOpacity,
          ),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
