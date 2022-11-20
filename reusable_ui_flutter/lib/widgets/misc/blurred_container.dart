import 'dart:ui';

import 'package:flutter/material.dart';

// ```
// BlurredContainer(
//   width: 200,
//   height: 200,
//   opacity: 0.1,
//   blur: 8,
//   accentColor: Colors.pinkAccent,
//   boxDecoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: const FlutterLogo(size: 100),
// )
// ```

class BlurredContainer extends StatelessWidget {
  const BlurredContainer({
    super.key,
    required this.width,
    required this.height,
    this.paddingChild = 0.0,
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
  final double paddingChild;
  final Widget child;
  final Color accentColor;
  final BoxDecoration? boxDecoration;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.all(paddingChild),
              child: Center(child: child),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                decoration: boxDecoration?.copyWith(
                  color: accentColor.withOpacity(opacity),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
