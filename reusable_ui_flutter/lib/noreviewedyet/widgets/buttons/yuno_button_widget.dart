import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';

class YunoButton extends StatelessWidget {
  const YunoButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width = 200,
    this.height = 60,
    this.fill = true,
    this.primaryColor = kPrimaryColor,
  }) : super(key: key);

  final double width, height;
  final bool fill;
  final String label;
  final Color primaryColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: fill ? primaryColor : kWhiteColor,
          primary: kWhiteColor,
          side: BorderSide(
            color: primaryColor,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: fill ? kWhiteColor : primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
