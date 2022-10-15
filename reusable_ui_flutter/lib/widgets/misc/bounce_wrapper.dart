import 'package:flutter/material.dart';

/// ```
/// BounceWrapper(
///   child: Container(
///     width: 100,
///     height: 40,
///     color: Colors.amber,
///     child: const Center(
///       child: Text('Widget'),
///     ),
///   ),
/// )
/// ```

class BounceWrapper extends StatefulWidget {
  const BounceWrapper({
    super.key,
    required this.child,
    this.scale = 0.2,
    this.onPressed,
    this.duration = const Duration(milliseconds: 250),
  });

  final Widget child;
  final double scale;
  final VoidCallback? onPressed;
  final Duration duration;

  @override
  BounceWrapperState createState() => BounceWrapperState();
}

class BounceWrapperState extends State<BounceWrapper>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _animate;

  @override
  void initState() {
    //defining the controller
    _animate = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 0.0,
      upperBound: widget.scale,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return GestureDetector(
        onTap: _onTap,
        child: Transform.scale(
          scale: _scale,
          child: widget.child,
        ));
  }

  void _onTap() {
    _animate.forward();

    //Now reversing the animation after the user defined duration
    Future.delayed(widget.duration, () {
      _animate.reverse();
      widget.onPressed?.generic();
    });
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }
}
