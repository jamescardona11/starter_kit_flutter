import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MultiFab extends StatefulWidget {
  const MultiFab({
    super.key,
    required this.children,
    this.foldedIcon = const Icon(Icons.apps),
    this.unfoldedIcon = const Icon(Icons.clear),
    this.shape = const CircleBorder(),
    this.animationDuration = const Duration(milliseconds: 400),
    this.color = Colors.blue,
    this.onTap,
  });

  final Widget unfoldedIcon;
  final Widget foldedIcon;

  final List<MultiFabItem> children;

  final ShapeBorder shape;
  final Duration animationDuration;

  final Color color;
  final Function? onTap;

  @override
  State<MultiFab> createState() => _MultiFabState();
}

class _MultiFabState extends State<MultiFab> {
  final _key = LabeledGlobalKey("button_icon");

  late OverlayEntry _overlayEntry;
  late Size buttonSize;
  late Offset buttonPosition;

  final isMenuOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => {findButton()});
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: widget.shape,
      backgroundColor: widget.color,
      key: _key,
      onPressed: null,
      child: ValueListenableBuilder<bool>(
        valueListenable: isMenuOpen,
        builder: (_, value, __) => InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              if (widget.onTap != null) widget.onTap!();
              value ? closeMenu() : openMenu();
            },
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: value ? widget.unfoldedIcon : widget.foldedIcon,
            )),
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() => OverlayEntry(
        builder: (context) {
          return Positioned(
            top: buttonPosition.dy - (widget.children.length * 50),
            left: buttonPosition.dx,
            width: buttonSize.width,
            child: Material(
              color: Colors.transparent,
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: List.generate(
                  widget.children.length,
                  (index) {
                    final itemsLength = widget.children.length;
                    return _AnimatedElement(
                      begin: index * (1 / itemsLength),
                      end: (index + 1) * (1 / itemsLength),
                      animationDuration: widget.animationDuration,
                      child: widget.children[index],
                    );
                  },
                ),
              ),
            ),
          );
        },
      );

  void findButton() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void openMenu() {
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    isMenuOpen.value = !isMenuOpen.value;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen.value = !isMenuOpen.value;
  }
}

class _AnimatedElement extends StatefulWidget {
  const _AnimatedElement({
    required this.animationDuration,
    required this.child,
    required this.begin,
    required this.end,
  });

  final double begin;
  final double end;
  final Widget child;
  final Duration animationDuration;

  @override
  _AnimatedElementState createState() => _AnimatedElementState();
}

class _AnimatedElementState extends State<_AnimatedElement>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> moveUpAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    initAnimations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => Opacity(
        opacity: opacityAnimation.value,
        child: Transform.translate(
          offset: Offset(0, moveUpAnimation.value),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initAnimations() {
    final interval = Interval(
      widget.begin,
      widget.end,
      curve: Curves.linear,
    );

    opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: interval,
    ));

    moveUpAnimation = Tween(
      begin: 15.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: interval,
    ));
  }
}

class MultiFabItem extends StatelessWidget {
  const MultiFabItem({
    super.key,
    required this.onPressed,
    this.shape = const CircleBorder(),
    this.child = const Icon(
      Icons.headphones,
      color: Colors.white,
      size: 10,
    ),
    this.color = Colors.blue,
  });

  final VoidCallback onPressed;
  final ShapeBorder shape;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: onPressed,
      shape: shape,
      backgroundColor: color,
      child: child,
    );
  }
}
