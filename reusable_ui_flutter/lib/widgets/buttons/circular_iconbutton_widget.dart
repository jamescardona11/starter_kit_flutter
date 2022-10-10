import 'package:flutter/material.dart';

/// ```
/// CircularIconButton(
///   icon: Icons.near_me,
///   onPressed: () {},
/// )
/// ```

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.iconColor = Colors.pinkAccent,
    this.backgroundColor = Colors.white,
    this.iconSize = 32,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final buttonSize = iconSize + 20;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: backgroundColor,
      ),
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
