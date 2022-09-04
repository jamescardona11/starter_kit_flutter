import 'package:flutter/material.dart';

class BottomElevenItem {
  BottomElevenItem({
    required this.icon,
    this.label = '',
    this.activeColor,
    this.inactiveColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color? activeColor;
  final Color? inactiveColor;
  final ValueChanged<int>? onTap;

  @override
  String toString() {
    return 'ElevenBottomItem(icon: $icon, label: $label, activeColor: $activeColor, inactiveColor: $inactiveColor)';
  }

  @override
  bool operator ==(covariant BottomElevenItem other) {
    if (identical(this, other)) return true;

    return other.icon == icon &&
        other.label == label &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor;
  }

  @override
  int get hashCode {
    return icon.hashCode ^
        label.hashCode ^
        activeColor.hashCode ^
        inactiveColor.hashCode ^
        onTap.hashCode;
  }
}
