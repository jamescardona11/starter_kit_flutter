import 'package:flutter/material.dart';

import 'common/bottom_bar_controller.dart';
import 'common/bottom_item.dart';

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
    this.margin = 20,
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
    final size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        margin: EdgeInsets.all(widget.margin),
        height: size.width * 0.155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              margin:
                                  EdgeInsets.only(bottom: isCurrent ? 0 : 12),
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
        ),
      ),
    );
  }
}
