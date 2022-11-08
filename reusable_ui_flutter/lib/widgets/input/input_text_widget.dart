import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// todo errors with height
/// ```
/// InputTextWidget(
///   hint: 'Enter your email',
///   leadingIconConfig: LeadingIconConfig(
///     leadingIcon: Icons.mail,
///   ),
///   onChanged: (value) {},
/// )
/// ```

typedef InputTextWidgetValidator<T> = String? Function(T? value);

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 10,
    this.maxLines = 1,
    this.contentPadding = 10,
    this.background = Colors.transparent,
    this.cursorColor,
    this.boxShadow,
    this.hint,
    this.label,
    // this.errorText,
    this.inputFormatter = const [],
    this.style = const ConfigStylesInputWidget(),
    this.leading,
    this.trailing,
    this.isEditable = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.validator,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final int maxLines;
  final double contentPadding;

  final Color background;
  final Color? cursorColor;
  final BoxShadow? boxShadow;

  final String? hint;
  final String? label;
  final ConfigStylesInputWidget style;
  final List<TextInputFormatter> inputFormatter;

  final LeadingIconConfig? leading;
  final Widget? trailing;
  final bool isEditable;
  final bool obscureText;

  final TextInputType keyboardType;
  final FocusNode? focusNode;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final InputTextWidgetValidator? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: background,
          boxShadow: boxShadow != null ? [boxShadow!] : null,
        ),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          obscureText: obscureText,
          cursorColor: cursorColor,
          keyboardType: keyboardType,
          focusNode: focusNode,
          inputFormatters: inputFormatter,
          validator: validator,
          decoration: InputDecoration(
            enabled: isEditable,
            hintText: hint,
            hintStyle: style.getHintStyle,
            // errorText: errorText,
            errorStyle: style.getErrorStyle,
            labelText: label,
            labelStyle: style.getLabelStyle,
            contentPadding: EdgeInsets.symmetric(horizontal: contentPadding),
            focusedBorder: _outlineBorderGray,
            enabledBorder: _outlineBorderGray,
            disabledBorder: _outlineBorderGray,
            errorBorder: _outlineBorderRed,
            focusedErrorBorder: _outlineBorderRed,
            suffixIcon: trailing,
            prefixIcon: leading?.child,
          ),
          style: style.getTextStyle,
        ),
      ),
    );
  }

  OutlineInputBorder get _outlineBorderGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: style.borderColor),
      );

  OutlineInputBorder get _outlineBorderRed => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: style.errorColor),
      );

  static Widget passwordIcon({
    required Color color,
    Color? enableColor,
    VoidCallback? onPressed,
  }) =>
      _TrailingVisibilityWidget(
        color: color,
        onTap: onPressed,
      );
}

class LeadingIconConfig {
  final IconData? icon;
  final Color defaultIconColor;
  final Color validIconColor;
  final Color errorIconColor;

  final bool? isValid;

  const LeadingIconConfig(
    this.icon, {
    this.defaultIconColor = Colors.grey,
    this.validIconColor = Colors.blueGrey,
    this.errorIconColor = const Color(0xFFF24A4A),
    this.isValid,
  });

  // null => default
  // valid == true => validIconColor
  // valid == false => errorIconColor
  Color get _getLeadingIconColor {
    if (isValid == null) return defaultIconColor;
    if (isValid!) return validIconColor;

    return errorIconColor;
  }

  Widget? get child => icon == null
      ? null
      : Icon(
          icon,
          color: _getLeadingIconColor,
        );
}

class ConfigStylesInputWidget {
  final double fontSize;
  final FontWeight fontWeight;

  final Color borderColor;
  final Color hintOrLabelColor;
  final Color textColor;
  final Color errorColor;

  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final TextStyle? labelStyle;

  const ConfigStylesInputWidget({
    this.borderColor = const Color.fromRGBO(0, 0, 0, 0.1),
    this.hintOrLabelColor = const Color(0xFFA6A8B4),
    this.textColor = const Color(0xFF333333),
    this.errorColor = const Color(0xFFF24A4A),
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.hintStyle,
    this.textStyle,
    this.errorStyle,
    this.labelStyle,
  });

  TextStyle get getHintStyle =>
      hintStyle ??
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: hintOrLabelColor,
      );

  TextStyle get getTextStyle =>
      textStyle ??
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      );

  TextStyle get getErrorStyle =>
      errorStyle ??
      TextStyle(
        fontSize: fontSize - 2,
        fontWeight: fontWeight,
        color: errorColor,
      );

  TextStyle get getLabelStyle =>
      labelStyle ??
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: hintOrLabelColor,
      );
}

class _TrailingVisibilityWidget extends StatelessWidget {
  const _TrailingVisibilityWidget({
    required this.color,
    this.onTap,
  });

  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        Icons.remove_red_eye,
        color: color,
      ),
    );
  }
}
