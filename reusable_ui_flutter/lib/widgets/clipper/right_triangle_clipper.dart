import 'package:flutter/material.dart';

/// ```
/// RightTriangleClipper()
/// ```
class RightTriangleClipper extends StatelessWidget {
  /// default constructor
  const RightTriangleClipper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _DifficultyClipper(),
      child: Container(
        constraints: const BoxConstraints(minWidth: 80),
        color: Colors.amber,
        padding: const EdgeInsets.all(5),
        child: const Text('Basic'),
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
