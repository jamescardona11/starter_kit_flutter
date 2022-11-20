import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/widgets/fab/common/fab_item.dart';

// Internal dependencies
// - FabElevenItem
//
// ```
// floatingActionButton: RowFab(
//   items: [
//     FabElevenItem.row(
//       onPressed: () {},
//       icon: const Icon(
//         Icons.home,
//         color: Colors.white,
//       ),
//     ),
//     FabElevenItem.row(
//       onPressed: () {},
//       icon: const Icon(
//         Icons.favorite,
//         color: Colors.white,
//       ),
//     ),
//     FabElevenItem.row(
//       onPressed: () {},
//       icon: const Icon(
//         Icons.person,
//         color: Colors.white,
//       ),
//     ),
//   ],
//   color: Colors.pinkAccentAccent,
//   elevation: 4,
//   // heroTag: 'aswdw',
// ),
// ```

class RowFab extends StatelessWidget {
  final List<FabElevenItem> items;

  final Axis axis;
  final double elevation;
  final Color? color;

  final double height;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;

  const RowFab({
    Key? key,
    required this.items,
    this.axis = Axis.horizontal,
    this.elevation = 6,
    this.color,
    this.height = 56,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBorderRadius =
        BorderRadius.circular((height + padding.top + padding.bottom) / 2);

    final finalHeight =
        axis == Axis.horizontal ? height + padding.top + padding.bottom : null;
    final finalWidth =
        axis == Axis.horizontal ? null : height + padding.left + padding.right;

    return Material(
      shape: shape,
      elevation: elevation,
      borderRadius:
          borderRadius ?? (shape == null ? defaultBorderRadius : null),
      child: ClipRRect(
        borderRadius: borderRadius ?? defaultBorderRadius,
        child: Container(
          color: color,
          height: finalHeight,
          width: finalWidth,
          padding: padding,
          child: Visibility(
            visible: axis == Axis.horizontal,
            replacement: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: items,
            ),
          ),
        ),
      ),
    );
  }
}
