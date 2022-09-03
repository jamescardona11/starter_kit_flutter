import 'package:flutter/material.dart';

class SliderDots extends StatefulWidget {
  const SliderDots({
    super.key,
    required this.totalSlides,
    required this.controller,
    this.dotsSpace = 5,
    this.dotsSize = 12,
    this.secondaryDotsSize = 15,
    this.primaryColor = Colors.redAccent,
    this.accentColor = Colors.grey,
    this.shape = BoxShape.circle,
  });

  final int totalSlides;

  final double dotsSpace;
  final double dotsSize;
  final double secondaryDotsSize;

  final Color accentColor;
  final Color primaryColor;
  final BoxShape shape;

  final PageController controller;

  @override
  State<SliderDots> createState() => _SliderDotsState();
}

class _SliderDotsState extends State<SliderDots> {
  final currentPageIndex = ValueNotifier<int>(0);
  @override
  void initState() {
    widget.controller.addListener(
      () {
        int current = currentPageIndex.value;
        double decimals = widget.controller.page! % 1;
        double newIndex = widget.controller.page ?? 0.0;

        // right slide
        if (decimals > 0.5) {
          currentPageIndex.value = newIndex.ceil();
          return;
        }

        // left slide
        if (current - newIndex > 0.5) {
          currentPageIndex.value = newIndex.floor();
          return;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ValueListenableBuilder<int>(
        valueListenable: currentPageIndex,
        builder: (_, value, __) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.totalSlides,
            (index) {
              bool changeIndex = value >= index - 0.5 && value < index + 0.5;
              return _Dot(
                changeIndex: changeIndex,
                accentColor: widget.accentColor,
                dotsSize: widget.dotsSize,
                dotsSpace: widget.dotsSpace,
                primaryColor: widget.primaryColor,
                secondaryDotsSize: widget.secondaryDotsSize,
                shape: widget.shape,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.secondaryDotsSize,
    required this.accentColor,
    required this.dotsSpace,
    required this.dotsSize,
    required this.primaryColor,
    required this.shape,
    this.changeIndex = false,
  });

  final bool changeIndex;
  final double dotsSpace;
  final double dotsSize;
  final double secondaryDotsSize;

  final Color accentColor;
  final Color primaryColor;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    EdgeInsets space = EdgeInsets.symmetric(horizontal: dotsSpace);
    Color color = accentColor;
    double size = dotsSize;

    if (changeIndex) {
      space = EdgeInsets.symmetric(horizontal: dotsSpace + 3)
          .add(const EdgeInsets.only(bottom: 4)) as EdgeInsets;
      size = secondaryDotsSize;
      color = primaryColor;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: space,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: shape,
      ),
    );
  }
}
