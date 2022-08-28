import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredContainer extends StatelessWidget {
  const BlurredContainer({
    super.key,
    required this.width,
    required this.height,
    this.opacity = 0.0,
    this.blur = 5,
    this.child = const SizedBox(),
    this.accentColor = Colors.transparent,
    this.boxDecoration,
  });

  final double width;
  final double height;
  final double opacity;
  final double blur;
  final Widget child;
  final Color accentColor;
  final BoxDecoration? boxDecoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: child),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              width: width,
              height: height,
              decoration: boxDecoration?.copyWith(
                color: accentColor.withOpacity(opacity),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
