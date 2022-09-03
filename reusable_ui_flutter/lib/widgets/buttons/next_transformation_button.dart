import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/custom_controller.dart';

// todo
// inner property to control the transform
// assert inner = true and controller == null ??

class NextTransformationButton extends StatefulWidget {
  const NextTransformationButton({
    Key? key,
    this.controller,
    this.topWidget,
    this.bottomWidget,
    this.onNextPressed,
    this.onTransformPressed,
    this.labelTransform = 'Continue',
    this.icon = Icons.arrow_forward_ios_rounded,
    this.accentColor = Colors.white,
    this.background = Colors.pinkAccent,
    this.forwardTransformation = false,
    this.reverseTransformation = false,
  }) : super(key: key);

  final Widget? topWidget;
  final Widget? bottomWidget;
  final VoidCallback? onNextPressed;
  final VoidCallback? onTransformPressed;
  final CustomController? controller;
  final IconData icon;
  final Color accentColor;
  final Color background;
  final String labelTransform;
  final bool forwardTransformation;
  final bool reverseTransformation;

  @override
  State<NextTransformationButton> createState() =>
      _NextTransformationButtonState();
}

class _NextTransformationButtonState extends State<NextTransformationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> transformButton;
  late Animation<Offset> bottomWidgetMoveAnimation;
  late CustomController customController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
      value: widget.controller?.initialValue ?? 0.0,
    );

    initAnimations();

    customController = widget.controller ?? CustomController();
    customController.setAnimationController(animationController);
  }

  @override
  void didUpdateWidget(covariant NextTransformationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.forwardTransformation != oldWidget.forwardTransformation ||
        widget.reverseTransformation != oldWidget.reverseTransformation) {
      customController.run();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.topWidget ?? const SizedBox(),
        AnimatedBuilder(
          animation: animationController,
          builder: (_, child) => PageTransitionSwitcher(
            duration: const Duration(milliseconds: 480),
            reverse: transformButton.value < 0.7,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                fillColor: Colors.transparent,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.vertical,
                child: child,
              );
            },
            child: SizedBox(
              width: 58 + (200 * transformButton.value),
              height: 58,
              child: OutlinedButton(
                key: const ValueKey('next_button'),
                onPressed: isNextButton
                    ? widget.onNextPressed
                    : widget.onTransformPressed,
                style: getButtonStyle(transformButton.value < 0.7),
                child: Visibility(
                  visible: transformButton.value < 0.7,
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.labelTransform,
                        style: TextStyle(
                          fontSize: 20,
                          color: widget.accentColor,
                        ),
                      ),
                      Icon(
                        widget.icon,
                        color: widget.accentColor,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.accentColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        SlideTransition(
          position: bottomWidgetMoveAnimation,
          child: widget.bottomWidget ?? const SizedBox(),
        ),
      ],
    );
  }

  bool get isNextButton => transformButton.value < 0.7;

  ButtonStyle getButtonStyle(bool showCircle) => OutlinedButton.styleFrom(
        shape: showCircle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
        primary: widget.accentColor,
        backgroundColor: widget.background,
      );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void initAnimations() {
    transformButton = Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.7,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    bottomWidgetMoveAnimation =
        Tween<Offset>(begin: const Offset(0, 4), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController
          ..duration = const Duration(milliseconds: 800),
        curve: const Interval(
          0.2,
          0.9,
          curve: Curves.linear,
        ),
      ),
    );
  }
}
