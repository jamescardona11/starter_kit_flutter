import 'package:flutter/material.dart';

import 'common/bottom_bar_controller.dart';
import 'common/bottom_item.dart';

// Internal dependencies
// - BottomElevenItem
// - BottomBarController
// - ArcBottomBarType
//
///```
/// bottomNavigationBar: ArcBottomBar(
///   items: [
///     BottomElevenItem(
///       label: 'Home',
///       icon: Icons.home,
///     ),
///     BottomElevenItem(
///       label: 'Trending',
///       icon: Icons.trending_up,
///     ),
///     BottomElevenItem(
///       label: 'Search',
///       icon: Icons.search,
///     ),
///   ],
///   onItemSelected: (index) {
///     print(index);
///   },
/// ),
/// ```

enum ArcBottomBarType {
  lightIcon,
  changeToText,
  iconAndText,
}

class ArcBottomBar extends StatefulWidget {
  const ArcBottomBar({
    super.key,
    this.items = const [],
    this.initialIndex = 0,
    this.borderRadius = 0,
    this.onItemSelected,
    this.controller,
    this.background = Colors.white,
    this.activeColor = Colors.pinkAccent,
    this.inactiveColor = Colors.black,
    this.type = ArcBottomBarType.lightIcon,
  });

  final List<BottomElevenItem> items;
  final BottomBarController? controller;
  final ValueChanged<int>? onItemSelected;
  final ArcBottomBarType type;
  final int initialIndex;
  final double borderRadius;
  final Color background;
  final Color activeColor;
  final Color inactiveColor;

  @override
  State<ArcBottomBar> createState() => _ArcBottomBarState();
}

class _ArcBottomBarState extends State<ArcBottomBar> {
  late final BottomBarController controller;

  @override
  void initState() {
    controller = widget.controller ?? BottomBarController(widget.initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DecoratedBox(
        decoration: decorationBottomBar(),
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, child) => Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.items.map((item) {
              final index = widget.items.indexOf(item);
              return Expanded(
                child: AnimatedContainer(
                  height: controller.visible ? 80 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      item.onTap?.call(index);
                      widget.onItemSelected?.call(index);

                      if (index == controller.index) return;
                      controller.changeIndex(index);
                    },
                    child: BottomBarItem(
                      item: item,
                      isSelected: index == controller.index,
                      type: widget.type,
                      activeColor: widget.activeColor,
                      inactiveColor: widget.inactiveColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  BoxDecoration decorationBottomBar() => BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.borderRadius),
          topRight: Radius.circular(widget.borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 15,
          )
        ],
      );
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    Key? key,
    required this.item,
    required this.activeColor,
    required this.inactiveColor,
    required this.type,
    this.isSelected = false,
  }) : super(key: key);

  final BottomElevenItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final ArcBottomBarType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ArcBottomBarType.lightIcon:
        return Center(
          child: defaultIcon,
        );

      case ArcBottomBarType.changeToText:
        return Center(
          child: AnimatedSwitcher(
            duration: duration,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            child: isSelected ? defaultText : defaultIcon,
          ),
        );

      case ArcBottomBarType.iconAndText:
        return Center(
          child: AnimatedCrossFade(
            crossFadeState: isSelected
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: duration,
            layoutBuilder:
                (topChild, topChildKey, bottomChild, bottomChildKey) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    key: bottomChildKey,
                    top: 0,
                    child: bottomChild,
                  ),
                  Positioned(
                    key: topChildKey,
                    child: topChild,
                  )
                ],
              );
            },
            firstChild: defaultIcon,
            secondChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                children: [
                  defaultIcon,
                  const SizedBox(height: 4),
                  defaultText,
                ],
              ),
            ),
          ),
        );
    }
  }

  Duration get duration => const Duration(milliseconds: 250);

  Color get iconColor => isSelected
      ? item.activeColor ?? activeColor
      : item.inactiveColor ?? inactiveColor;

  Widget get defaultIcon => Icon(
        item.icon,
        color: iconColor,
      );

  Widget get defaultText => Text(
        item.label,
        style: TextStyle(
          color: item.activeColor ?? activeColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
}
