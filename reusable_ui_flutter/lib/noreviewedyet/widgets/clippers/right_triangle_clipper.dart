import 'package:flutter/material.dart';

class RightTriangleClipperWidget extends StatelessWidget {
  /// default constructor
  const RightTriangleClipperWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _DifficultyClipper(),
      child: Container(
        constraints: const BoxConstraints(minWidth: 80),
        color: Colors.red,
        padding: const EdgeInsets.all(5),
        child: const Text('Básico'),
      ),
    );
  }
}

class _DifficultyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<dynamic> oldClipper) => false;
}
