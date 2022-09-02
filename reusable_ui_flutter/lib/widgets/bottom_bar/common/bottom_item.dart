import 'package:flutter/material.dart';

class ElevenBottomItem {
  ElevenBottomItem({
    required this.icon,
    this.label = '',
    this.activeColor,
    this.inActiveColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color? activeColor;
  final Color? inActiveColor;
  final ValueChanged<int>? onTap;
}
