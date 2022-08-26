import 'package:reusable_ui_flutter/colors.dart';

import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/dimens.dart';

class ExaButton extends StatelessWidget {
  const ExaButton({
    Key? key,
    this.width = 170,
    this.height = 55,
    this.enable = true,
    this.backgroundColor = kWhiteColor,
    this.textColor = kBlackColor,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String label;
  final bool enable;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
          shape: const RoundedRectangleBorder(
            borderRadius: borderRadiusNormal,
          ),
        ),
        onPressed: enable ? onPressed : null,
        child: Text(label),
      ),
    );
  }
}
