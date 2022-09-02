import 'package:flutter/material.dart';

import 'common/bottom_item.dart';

class FloatingBottomBar extends StatefulWidget {
  const FloatingBottomBar({
    Key? key,
    required this.items,
    this.selectedIndex = 0,
    this.duration = const Duration(milliseconds: 1500),
    this.activeColor = Colors.blue,
    this.inActiveColor = Colors.black38,
    this.margin = 20,
    this.onItemSelected,
  }) : super(key: key);

  final List<ElevenBottomItem> items;
  final int selectedIndex;
  final Duration duration;
  final Color activeColor;
  final Color inActiveColor;
  final double margin;
  final ValueChanged<int>? onItemSelected;

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  late final ValueNotifier<int> _index;

  @override
  void initState() {
    _index = ValueNotifier<int>(widget.selectedIndex);
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
                return InkWell(
                  onTap: () {
                    _index.value = index;
                    item.onTap?.call(index);
                    widget.onItemSelected?.call(index);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _index,
                    builder: (_, currentIndex, __) {
                      final item = widget.items[index];
                      final isCurrent = index == currentIndex;

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
                            size: 30,
                            color: isCurrent
                                ? item.activeColor ?? widget.activeColor
                                : item.inActiveColor ?? widget.inActiveColor,
                          ),
                          // SizedBox(height: size.width * .03),
                        ],
                      );
                    },
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
