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
    this.baseWidget,
    this.onNextPressed,
    this.onTransformPressed,
    this.labelTransform = 'Continue',
    this.icon = Icons.arrow_forward_ios_rounded,
    this.accentColor = Colors.white,
    this.background = Colors.blue,
  }) : super(key: key);

  final Widget? baseWidget;
  final VoidCallback? onNextPressed;
  final VoidCallback? onTransformPressed;
  final CustomController? controller;
  final IconData icon;
  final Color accentColor;
  final Color background;
  final String labelTransform;

  @override
  State<NextTransformationButton> createState() =>
      _NextTransformationButtonState();
}

class _NextTransformationButtonState extends State<NextTransformationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _signUpMoveAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
      value: widget.controller?.initialValue ?? 0.0,
    );

    initAnimations();

    widget.controller?.setAnimationController(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.baseWidget ?? const SizedBox(),
        AnimatedBuilder(
          animation: animationController,
          builder: (_, child) => PageTransitionSwitcher(
            duration: const Duration(milliseconds: 480),
            reverse: _signUpMoveAnimation.value < 0.7,
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
              width: 58 + (200 * _signUpMoveAnimation.value),
              height: 58,
              child: OutlinedButton(
                key: const ValueKey('next_button'),
                onPressed: isNextButton
                    ? widget.onNextPressed
                    : widget.onTransformPressed,
                style: getButtonStyle(_signUpMoveAnimation.value < 0.7),
                child: Visibility(
                  visible: _signUpMoveAnimation.value < 0.7,
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.labelTransform,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
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
      ],
    );
  }

  bool get isNextButton => _signUpMoveAnimation.value < 0.7;

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
    _signUpMoveAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.7,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    // _loginTextMoveAnimation =
    //     Tween<Offset>(begin: const Offset(0, 8), end: const Offset(0, 0))
    //         .animate(CurvedAnimation(
    //   parent: animationController,
    //   curve: const Interval(
    //     0.3,
    //     0.6,
    //     curve: Curves.fastOutSlowIn,
    //   ),
    // ));
  }
}
