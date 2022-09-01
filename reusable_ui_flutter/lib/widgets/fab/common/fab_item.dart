import 'package:flutter/material.dart';

// todo mejorar parecido al [ElevenBottomItem]

class ElevenFabItem extends StatelessWidget {
  const ElevenFabItem._({
    super.key,
    required this.onPressed,
    required this.multi,
    required this.shape,
    required this.icon,
    required this.color,
    this.padding = const EdgeInsets.all(0),
    this.size,
  });

  factory ElevenFabItem.multi({
    Key? key,
    required VoidCallback onPressed,
    ShapeBorder? shape,
    Icon? icon,
    Color? color,
    EdgeInsets? padding,
  }) =>
      ElevenFabItem._(
        key: key,
        onPressed: onPressed,
        shape: shape ?? const CircleBorder(),
        icon: icon ??
            const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 10,
            ),
        color: color ?? Colors.blue,
        padding: padding ?? const EdgeInsets.all(0),
        multi: true,
      );

  factory ElevenFabItem.row({
    Key? key,
    required VoidCallback onPressed,
    double? size,
    ShapeBorder? shape,
    Icon? icon,
    Color? color,
    EdgeInsets? padding,
  }) =>
      ElevenFabItem._(
        key: key,
        size: size,
        onPressed: onPressed,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
        icon: icon ??
            const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 10,
            ),
        color: color ?? Colors.blue,
        padding: padding ?? const EdgeInsets.all(0),
        multi: false,
      );

  final VoidCallback onPressed;
  final ShapeBorder shape;
  final double? size;
  final Icon? icon;
  final Color? color;
  final EdgeInsets padding;
  final bool multi;

  @override
  Widget build(BuildContext context) {
    if (multi) {
      return FloatingActionButton(
        mini: true,
        onPressed: onPressed,
        shape: shape,
        backgroundColor: color,
        child: icon,
      );
    }

    return LayoutBuilder(
      builder: (_, constraints) {
        bool isColumn = false;
        if (constraints.maxHeight > constraints.maxWidth) {
          isColumn = true;
        }
        double defaultSize =
            isColumn ? constraints.maxWidth : constraints.maxHeight;

        return SizedBox(
          width: size ?? defaultSize,
          height: size ?? defaultSize,
          child: RawMaterialButton(
            elevation: 0,
            highlightElevation: 0,
            fillColor: color,
            padding: padding,
            shape: shape,
            onPressed: onPressed,
            child: icon,
          ),
        );
      },
    );
  }
}
