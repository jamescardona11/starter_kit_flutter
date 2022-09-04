import 'dart:math';

import 'package:flutter/material.dart';

class PointsLoader extends StatefulWidget {
  final List<LoadingPointConfig> loadingPoints;

  const PointsLoader._(this.loadingPoints);

  factory PointsLoader.triangle({List<Color> colors = _defaultColors}) =>
      PointsLoader._(_triangleConfig(colors));

  factory PointsLoader.square({List<Color> colors = _defaultColors}) =>
      PointsLoader._(_squareConfig(colors));

  factory PointsLoader.pentagon({List<Color> colors = _defaultColors}) =>
      PointsLoader._(_pentagonConfig(colors));

  factory PointsLoader.hexagon({List<Color> colors = _defaultColors}) =>
      PointsLoader._(_hexagonConfig(colors));

  factory PointsLoader.circle({List<Color> colors = _defaultColors}) =>
      PointsLoader._(_circleConfig(colors));

  static const _defaultColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ];

  static List<LoadingPointConfig> _triangleConfig(List<Color> colors) {
    return List<LoadingPointConfig>.of(
      [
        LoadingPointConfig(color: colors[0], xMultiplier: -1, yMultiplier: -1),
        LoadingPointConfig(color: colors[1], xMultiplier: 0),
        LoadingPointConfig(color: colors[2], yMultiplier: -1),
      ],
    );
  }

  static List<LoadingPointConfig> _squareConfig(List<Color> colors) {
    return List<LoadingPointConfig>.of(
      [
        LoadingPointConfig(color: colors[0], xMultiplier: -1),
        LoadingPointConfig(color: colors[1]),
        LoadingPointConfig(color: colors[2], yMultiplier: -1),
        LoadingPointConfig(color: colors[3], xMultiplier: -1, yMultiplier: -1),
      ],
    );
  }

  static List<LoadingPointConfig> _pentagonConfig(List<Color> colors) {
    const xU = 0.9510;
    const yU = 0.3090;
    const xD = 0.5877;
    const yD = -0.8090;
    return List<LoadingPointConfig>.of(
      [
        LoadingPointConfig(color: colors[0], xMultiplier: -xU, yMultiplier: yU),
        LoadingPointConfig(color: colors[1], xMultiplier: 0),
        LoadingPointConfig(color: colors[2], xMultiplier: xU, yMultiplier: yU),
        LoadingPointConfig(color: colors[3], xMultiplier: xD, yMultiplier: yD),
        LoadingPointConfig(color: colors[4], xMultiplier: -xD, yMultiplier: yD),
      ],
    );
  }

  static List<LoadingPointConfig> _hexagonConfig(List<Color> colors) {
    const x = 0.5;
    const y = 0.866;
    return List<LoadingPointConfig>.of(
      [
        LoadingPointConfig(color: colors[0], xMultiplier: -1, yMultiplier: 0),
        LoadingPointConfig(color: colors[1], xMultiplier: -x, yMultiplier: y),
        LoadingPointConfig(color: colors[2], xMultiplier: x, yMultiplier: y),
        LoadingPointConfig(color: colors[3], yMultiplier: 0),
        LoadingPointConfig(color: colors[4], xMultiplier: x, yMultiplier: -y),
        LoadingPointConfig(color: colors[5], xMultiplier: -x, yMultiplier: -y),
      ],
    );
  }

  static List<LoadingPointConfig> _circleConfig(List<Color> colors) {
    const s = 0.7071;
    return List<LoadingPointConfig>.of(
      [
        LoadingPointConfig(color: colors[0], xMultiplier: -1, yMultiplier: 0),
        LoadingPointConfig(color: colors[1], xMultiplier: -s, yMultiplier: s),
        LoadingPointConfig(color: colors[2], xMultiplier: 0),
        LoadingPointConfig(color: colors[3], xMultiplier: s, yMultiplier: s),
        LoadingPointConfig(color: colors[4], yMultiplier: 0),
        LoadingPointConfig(color: colors[5], xMultiplier: s, yMultiplier: -s),
        LoadingPointConfig(color: colors[6], xMultiplier: 0, yMultiplier: -1),
        LoadingPointConfig(color: colors[7], xMultiplier: -s, yMultiplier: -s),
      ],
    );
  }

  @override
  State<PointsLoader> createState() => _PointsLoaderState();
}

class _PointsLoaderState extends State<PointsLoader>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  bool hasShuffledPoints = false;
  final List<Widget> _loadingPoints = [];
  final double containerSize = 100.0;

  @override
  void initState() {
    super.initState();
    _initAnimations();

    _controller.forward();

    final loadingPointTransitions =
        loadingPointConfigsToTransitions(widget.loadingPoints, containerSize);
    _loadingPoints.addAll(loadingPointTransitions);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: Center(
        child: Container(
          width: containerSize,
          height: containerSize,
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => Stack(
              alignment: Alignment.center,
              children: _loadingPoints,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initAnimations() {
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..addListener(() {
            if (!hasShuffledPoints) {
              if (_controller.lastElapsedDuration != null &&
                  _controller.lastElapsedDuration!.inMilliseconds >
                      _controller.duration!.inMilliseconds / 2) {
                _shufflePoints();
                hasShuffledPoints = true;
              }
            }
          })
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                hasShuffledPoints = false;
                _controller.reset();
                _controller.forward();
              }
            },
          );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0,
          1,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  List<_LoadingPointTransition> loadingPointConfigsToTransitions(
      List<LoadingPointConfig> pointConfig, double containerSize) {
    final loadingPoints = <_LoadingPointTransition>[];
    for (final pointConfig in widget.loadingPoints) {
      loadingPoints.add(
        _LoadingPointTransition(
          controller: _controller,
          color: pointConfig.color,
          xMultiplier: pointConfig.xMultiplier,
          yMultiplier: pointConfig.yMultiplier,
          parentSize: containerSize,
        ),
      );
    }

    return loadingPoints;
  }

  void _shufflePoints() {
    final lastPosition = _loadingPoints.length - 1;
    final newPosition = Random().nextInt(lastPosition);
    final temp = _loadingPoints[newPosition];

    _loadingPoints[newPosition] = _loadingPoints.last;
    _loadingPoints[lastPosition] = temp;
  }
}

class LoadingPointConfig {
  final Color color;
  final double xMultiplier;
  final double yMultiplier;

  const LoadingPointConfig({
    this.color = Colors.white,
    this.xMultiplier = 1,
    this.yMultiplier = 1,
  });
}

class _LoadingPointTransition extends AnimatedWidget {
  static RelativeRect centerRect(double parentSize, double pointSize) {
    final margin = (parentSize - pointSize) / 2;
    return RelativeRect.fromLTRB(margin, margin, margin, margin);
  }

  static RelativeRect expandedRect(double parentSize, double pointSize,
      double xMultiplier, double yMultiplier, double expansionScale) {
    final centerMargin = (parentSize - pointSize) / 2;
    final xMargin = pointSize * expansionScale * xMultiplier;
    final yMargin = pointSize * expansionScale * yMultiplier;
    return RelativeRect.fromLTRB(centerMargin + xMargin, centerMargin - yMargin,
        centerMargin - xMargin, centerMargin + yMargin);
  }

  _LoadingPointTransition({
    Key? key,
    required this.controller,
    this.xMultiplier = 1,
    this.yMultiplier = 1,
    this.parentSize = 100,
    this.pointSize = 20,
    this.color = Colors.white,
    this.expansionScale = 2,
  })  : expandRelativeRect = RelativeRectTween(
          begin: centerRect(parentSize, pointSize),
          end: expandedRect(
              parentSize, pointSize, xMultiplier, yMultiplier, expansionScale),
        ),
        contractRelativeRect = RelativeRectTween(
          begin: expandedRect(
              parentSize, pointSize, xMultiplier, yMultiplier, expansionScale),
          end: centerRect(parentSize, pointSize),
        ),
        super(key: key, listenable: controller);

  final Color color;
  final double parentSize;
  final double pointSize;
  final double xMultiplier;
  final double yMultiplier;
  final double expansionScale;
  final Animation<double> controller;
  final RelativeRectTween expandRelativeRect;
  final RelativeRectTween contractRelativeRect;

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: TweenSequence(<TweenSequenceItem<RelativeRect>>[
        TweenSequenceItem(
            tween:
                ConstantTween<RelativeRect>(centerRect(parentSize, pointSize)),
            weight: 13.0),
        TweenSequenceItem(
            tween: expandRelativeRect.chain(CurveTween(curve: Curves.easeOut)),
            weight: 29.0),
        TweenSequenceItem(
            tween: ConstantTween<RelativeRect>(expandedRect(parentSize,
                pointSize, xMultiplier, yMultiplier, expansionScale)),
            weight: 29.0),
        TweenSequenceItem(
            tween:
                contractRelativeRect.chain(CurveTween(curve: Curves.bounceOut)),
            weight: 29.0)
      ]).animate(controller),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
