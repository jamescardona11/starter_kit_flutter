import 'package:collection/collection.dart' show ListEquality;
import 'package:flutter/material.dart';

import '../common/bottom_bar_controller.dart';
import '../common/bottom_item.dart';
import 'bubble_selection_painter.dart';

class BeeBottomBar extends StatefulWidget {
  const BeeBottomBar({
    Key? key,
    required this.items,
    this.initialIndex = 0,
    this.controller,
    this.onItemSelected,
    this.background = Colors.black,
    this.specialColor = Colors.white,
    this.activeColor = Colors.pinkAccent,
    this.inactiveColor = Colors.grey,
    this.withSpecialOdd = true,
    this.splashAnimation = 28,
    this.borderRadius = 0,
    this.decoration = false,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final List<BottomElevenItem> items;
  final BottomBarController? controller;
  final ValueChanged<int>? onItemSelected;
  final Duration duration;
  final int initialIndex;
  final Color background;
  final Color specialColor;
  final Color activeColor;
  final Color inactiveColor;
  final bool withSpecialOdd;
  final bool decoration;
  final double splashAnimation;
  final double borderRadius;

  @override
  State<BeeBottomBar> createState() => _BeeBottomBarState();
}

class _BeeBottomBarState extends State<BeeBottomBar> {
  late final BottomBarController controller;
  final List<int> specialIndex = [];

  @override
  void initState() {
    controller = widget.controller ?? BottomBarController(widget.initialIndex);
    findSpecialIndex();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BeeBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!const ListEquality().equals(widget.items, oldWidget.items)) {
      findSpecialIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(bottom: 20),
      decoration: widget.decoration
          ? decorationBottomBar()
          : BoxDecoration(
              color: widget.background,
            ),
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.items.map((item) {
            final index = widget.items.indexOf(item);

            return InkWell(
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
              child: SizedBox(
                // width: widthItem,w
                // width: 60,
                child: _BottomBarItem(
                  activeColor: widget.activeColor,
                  inactiveColor: widget.inactiveColor,
                  isSelected: index == controller.index,
                  item: item,
                  maxSplashRadius: widget.splashAnimation,
                  isSpecial: specialIndex.contains(index),
                  duration: widget.duration,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  double get widthItem {
    final size = MediaQuery.of(context).size;
    return size.width * (1 - widget.items.length * 0.1) / widget.items.length;
  }

  BoxDecoration decorationBottomBar() => BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     width: 0.5,
        //     color: Colors.grey.shade200,
        //   ),
        // ),
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

  void findSpecialIndex() {
    specialIndex.clear();
    if (!widget.withSpecialOdd) return;
    final middle = (widget.items.length / 2).floor();
    specialIndex.add(middle);
    if (!widget.items.length.isOdd) {
      specialIndex.add(middle - 1);
    }
  }
}

class _BottomBarItem extends StatefulWidget {
  const _BottomBarItem({
    Key? key,
    required this.isSelected,
    required this.maxSplashRadius,
    required this.item,
    required this.activeColor,
    required this.inactiveColor,
    required this.duration,
    this.isSpecial = false,
  }) : super(key: key);

  final bool isSelected;
  final bool isSpecial;
  final double maxSplashRadius;

  final Color activeColor;
  final Color inactiveColor;
  final BottomElevenItem item;
  final Duration duration;

  @override
  State<_BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<_BottomBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double bubbleRadius = 0;
  double iconScale = 1;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final bubbleCurve = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    bubbleCurve.addListener(() {
      setState(() {
        bubbleRadius = widget.maxSplashRadius * bubbleCurve.value;
        if (bubbleRadius == widget.maxSplashRadius) {
          bubbleRadius = 0;
        }

        if (bubbleCurve.value < 0.5) {
          iconScale = 1 + bubbleCurve.value;
        } else {
          iconScale = 2 - bubbleCurve.value;
        }
      });
    });

    // controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        bubbleRadius: widget.isSelected ? bubbleRadius : 0,
        bubbleColor: widget.item.activeColor ?? widget.activeColor,
        maxBubbleRadius: widget.maxSplashRadius,
      ),
      child: Transform.scale(
        scale: widget.isSelected ? iconScale : 1,
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: widget.isSpecial
                ? const BorderRadius.all(Radius.circular(15))
                : null,
            color: widget.isSpecial ? Colors.white : Colors.transparent,
          ),
          child: Center(
            child: Icon(
              widget.item.icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _BottomBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (controller.isAnimating) {
        controller.stop();
      }
      controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color get iconColor => widget.isSelected
      ? widget.item.activeColor ?? widget.activeColor
      : widget.item.inactiveColor ?? widget.inactiveColor;
}
