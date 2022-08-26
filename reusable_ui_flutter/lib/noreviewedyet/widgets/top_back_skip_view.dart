import 'package:flutter/material.dart';

class TopBackSkipView extends StatefulWidget {
  const TopBackSkipView({
    Key? key,
    required this.onBackClick,
    required this.onSkipClick,
    this.showSkip = true,
  }) : super(key: key);

  final VoidCallback onBackClick;
  final VoidCallback onSkipClick;
  final bool showSkip;

  @override
  State<TopBackSkipView> createState() => _TopBackSkipViewState();
}

class _TopBackSkipViewState extends State<TopBackSkipView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
              Visibility(
                visible: widget.showSkip,
                child: TextButton(
                  onPressed: widget.onSkipClick,
                  child: Text('Omitir',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initAnimations() {
    _animation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(CurvedAnimation(
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
