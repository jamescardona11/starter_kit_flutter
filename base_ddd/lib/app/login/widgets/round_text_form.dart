import 'package:base_ddd/config/values/colors.dart';
import 'package:flutter/material.dart';

import 'edit_text_container.dart';

class RoundedTextForm extends StatelessWidget {
  const RoundedTextForm({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.suffixIcon,
    this.isPassword = false,
    this.validator = '',
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool isPassword;
  final String validator;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return EditTextContainer(
      errorValidator: validator,
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: kPrimary,
        obscureText: isPassword,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(),
          icon: Icon(
            icon,
            color: kPrimary,
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
