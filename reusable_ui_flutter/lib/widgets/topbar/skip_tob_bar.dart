import 'package:flutter/material.dart';

class SkipTopBar extends StatefulWidget {
  const SkipTopBar({
    Key? key,
    required this.onBackClick,
    this.center = const SizedBox(),
    this.offset = const Offset(0, -2),
    this.showSkip = true,
    this.onSkipClick,
    this.skipStyle,
  }) : super(key: key);

  final VoidCallback onBackClick;
  final VoidCallback? onSkipClick;
  final Offset offset;
  final Widget center;
  final bool showSkip;
  final TextStyle? skipStyle;

  @override
  State<SkipTopBar> createState() => _SkipTopBarState();
}

class _SkipTopBarState extends State<SkipTopBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    initAnimations();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: widget.onBackClick,
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              widget.center,
              Visibility(
                visible: widget.showSkip,
                child: TextButton(
                  onPressed: widget.onSkipClick,
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initAnimations() {
    _animation = Tween<Offset>(
      begin: widget.offset,
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
