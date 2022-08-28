import 'package:flutter/material.dart';

class EleventhButton extends StatelessWidget {
  const EleventhButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.radius = 15,
    this.fill = true,
    this.primaryColor,
    this.splashColor,
    this.accentColor = Colors.black,
  }) : super(key: key);

  final double width;
  final double height;
  final double radius;
  final bool fill;
  final String label;
  final Color? primaryColor;
  final Color? splashColor;
  final Color? accentColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: fill ? primaryColor : Colors.transparent,
          primary: splashColor ?? primaryColor,
          side: BorderSide(
            color: primaryColor ?? Colors.grey,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: fill ? accentColor : primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
