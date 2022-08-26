import 'package:flutter/material.dart';

class FadeVisibility extends StatelessWidget {
  const FadeVisibility({
    Key? key,
    required this.visible,
    required this.child,
  }) : super(key: key);

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: visible ? child : const SizedBox(),
    );
  }
}
