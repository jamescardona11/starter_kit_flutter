import 'package:flutter/material.dart';

class CustomController {
  final double initialValue;

  late AnimationController _controller;

  CustomController({
    this.initialValue = 0.0,
  });

  void forward({double? from}) => _controller.forward(from: from);

  void reverse({double? from}) => _controller.reverse(from: from);

  void run() {
    if (isAnimationCompleted) {
      reverse();
    } else if (isAnimationDismissed) {
      forward();
    }
  }

  void setAnimationController(AnimationController controller) {
    _controller = controller;
  }

  double get value => _controller.value;

  bool get isAnimationDismissed =>
      _controller.status == AnimationStatus.dismissed;

  bool get isAnimationCompleted =>
      _controller.status == AnimationStatus.completed;

  bool get isAnimating => _controller.isAnimating;
}
