import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';

class CircularIconButtonWidget extends StatelessWidget {
  const CircularIconButtonWidget({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.iconColor = kBlueColor,
    this.backgroundColor = kWhiteColor,
    this.iconSize = 32,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: backgroundColor,
      ),
      child: SizedBox(
        width: iconSize + 20,
        height: iconSize + 20,
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
