import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';

class EditTextContainer extends StatelessWidget {
  final Widget child;
  final double paddingHorizontal;
  final double paddingVertical;
  final double width;
  final double height;

  const EditTextContainer({
    Key? key,
    required this.child,
    this.paddingHorizontal = 0.0,
    this.paddingVertical = 0.0,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
