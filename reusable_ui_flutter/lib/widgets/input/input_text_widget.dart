import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    super.key,
    this.width,
    this.height,
    this.rounded = 15,
    this.hint,
    this.leadingIcon,
    this.trailing,
    this.iconColor = Colors.grey,
    this.background = Colors.transparent,
    this.borderColor = Colors.grey,
    this.validIconColor = Colors.pinkAccentGrey,
    this.cursorColor,
    this.obscureText = false,
    this.maxLines = 1,
    this.isValid,
    this.onChanged,
    this.onSuffixTap,
  })  : suffixColor = Colors.transparent,
        suffixEnableColor = Colors.transparent;

  InputTextWidget.password({
    super.key,
    this.width,
    this.height,
    this.rounded = 15,
    this.hint,
    this.leadingIcon,
    this.iconColor = Colors.grey,
    this.background = Colors.transparent,
    this.borderColor = Colors.grey,
    this.validIconColor = Colors.pinkAccentGrey,
    this.cursorColor,
    Color suffixIconColor = Colors.grey,
    Color? suffixEnableIconColor,
    this.obscureText = true,
    this.isValid,
    this.onChanged,
    this.onSuffixTap,
  })  : suffixColor = suffixIconColor,
        suffixEnableColor = suffixEnableIconColor,
        maxLines = 1,
        trailing = _TrailingVisibilityWidget(
          color: suffixIconColor,
          enableColor: suffixEnableIconColor,
        );

  final double? width;
  final double? height;
  final double rounded;
  final int maxLines;
  final String? hint;
  final IconData? leadingIcon;
  final Widget? trailing;
  final Color iconColor;
  final Color validIconColor;
  final Color? cursorColor;
  final Color background;
  final Color borderColor;
  final bool? isValid;
  final bool obscureText;
  final Color suffixColor;
  final Color? suffixEnableColor;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    // final neutralColor = borderColor.withOpacity(0.5);
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(
          color: borderColor.withOpacity(0.5),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(rounded),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: cursorColor,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          suffix: trailing,
          icon: Icon(
            leadingIcon,
            color: getLeadingIconColor,
          ),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
      ),
    );
  }

  Color get getLeadingIconColor {
    if (isValid == null || isValid == false) {
      return iconColor;
    }
    return validIconColor;
  }
}

class _TrailingVisibilityWidget extends StatelessWidget {
  const _TrailingVisibilityWidget({
    required this.color,
    this.enableColor,
  });

  final Color color;
  final Color? enableColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.remove_red_eye,
      color: enableColor ?? color,
    );
  }
}
