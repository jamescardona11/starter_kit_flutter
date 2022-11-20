import 'package:flutter/material.dart';

import 'common/bottom_bar_controller.dart';
import 'common/bottom_item.dart';

// Internal dependencies
// - BottomElevenItem
// - BottomBarController
//
//```
// bottomNavigationBar: FloatingBottomBar(
//   items: [
//     BottomElevenItem(
//       label: 'Home',
//       icon: Icons.home,
//     ),
//     BottomElevenItem(
//       label: 'Trending',
//       icon: Icons.trending_up,
//     ),
//     BottomElevenItem(
//       label: 'Search',
//       icon: Icons.search,
//     ),
//   ],
// ),
// ```

class FloatingBottomBar extends StatefulWidget {
  const FloatingBottomBar({
    Key? key,
    required this.items,
    this.initialIndex = 0,
    this.controller,
    this.duration = const Duration(milliseconds: 1500),
    this.background = Colors.white,
    this.activeColor = Colors.pinkAccent,
    this.inactiveColor = Colors.black,
    this.margin = 70,
    this.onItemSelected,
  }) : super(key: key);

  final List<BottomElevenItem> items;
  final BottomBarController? controller;
  final ValueChanged<int>? onItemSelected;
  final int initialIndex;
  final Duration duration;
  final Color background;
  final Color activeColor;
  final Color inactiveColor;
  final double margin;

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  late final BottomBarController controller;

  @override
  void initState() {
    controller = widget.controller ?? BottomBarController(widget.initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.margin,
        right: widget.margin,
        bottom: 35,
      ),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.items.map((item) {
            var index = widget.items.indexOf(item);
            return Expanded(
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
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (_, child) {
                    final item = widget.items[index];
                    final isCurrent = index == controller.index;

                    return Column(
                      children: [
                        AnimatedContainer(
                          width: 50,
                          height: isCurrent ? 6 : 0,
                          duration: widget.duration,
                          curve: Curves.fastLinearToSlowEaseIn,
                          margin: EdgeInsets.only(bottom: isCurrent ? 0 : 12),
                          decoration: BoxDecoration(
                            color: item.activeColor ?? widget.activeColor,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Icon(
                          item.icon,
                          size: 28,
                          color: isCurrent
                              ? item.activeColor ?? widget.activeColor
                              : item.inactiveColor ?? widget.inactiveColor,
                        ),
                        // SizedBox(height: size.width * .03),
                      ],
                    );
                  },
                ),
              ),
            );
          }).toList()),
    );
  }
}
