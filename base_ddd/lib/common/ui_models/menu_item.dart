import 'package:flutter/material.dart';

@immutable
class MenuItemUIM {
  const MenuItemUIM({
    required this.label,
    required this.icon,
    required this.route,
    this.isSelected = false,
    this.isSpecial = false,
  });

  final String label;
  final String route;
  final IconData icon;
  final bool isSelected;
  final bool isSpecial;

  MenuItemUIM copyWith({
    String? label,
    String? route,
    IconData? icon,
    bool? isSelected,
    bool? isSpecial,
  }) {
    return MenuItemUIM(
      label: label ?? this.label,
      route: route ?? this.route,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
      isSpecial: isSpecial ?? this.isSpecial,
    );
  }

  @override
  String toString() =>
      'MenuItem(name: $label, iconData: $icon, selected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MenuItemUIM &&
        other.label == label &&
        other.icon == icon &&
        other.route == route &&
        other.isSelected == isSelected &&
        other.isSpecial == isSpecial;
  }

  @override
  int get hashCode =>
      label.hashCode ^
      icon.hashCode ^
      route.hashCode ^
      isSelected.hashCode ^
      isSpecial.hashCode;
}
