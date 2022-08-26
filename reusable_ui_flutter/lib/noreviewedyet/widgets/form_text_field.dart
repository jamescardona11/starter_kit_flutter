import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';

class FormTextField extends StatefulWidget {
  final String _label;
  final String? _initialValue;
  final bool _obscureText;
  final String? _hintText;
  final Widget? _suffixIcon;
  final String? _validationError;
  final bool _checkIsDirtyForValidation;
  final ValueChanged<String>? _onChanged;

  const FormTextField({
    Key? key,
    required String label,
    String? initialValue,
    String? hintText,
    Widget? suffixIcon,
    String? validationError,
    bool obscureText = false,
    ValueChanged<String>? onChanged,
    bool checkIsDirtyForValidation = true,
  })  : _label = label,
        _hintText = hintText,
        _onChanged = onChanged,
        _suffixIcon = suffixIcon,
        _obscureText = obscureText,
        _initialValue = initialValue,
        _validationError = validationError,
        _checkIsDirtyForValidation = checkIsDirtyForValidation,
        super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool _isDirty = false;
  bool _hasLostFocus = false;
  bool _textHasChanged = false;
  bool _previouslyHadFocus = false;

  final FocusNode _focusNode = FocusNode();

  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    _initFocusNode();
    _initTextController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      style: const TextStyle(
        color: kWhiteColor,
      ),
      focusNode: _focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? newText) {
        if (widget._checkIsDirtyForValidation) {
          return _isDirty && widget._validationError?.isNotEmpty == true
              ? widget._validationError
              : null;
        }

        return widget._validationError;
      },
      obscureText: widget._obscureText,
      cursorColor: kGrayLightColor,
      decoration: InputDecoration(
        suffixIcon: widget._suffixIcon,
        labelText: widget._label,
        hintText: widget._hintText,
        hintStyle: TextStyle(color: kGrayLightColor),
        labelStyle: TextStyle(color: kGrayLightColor),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: kRedErrorColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: kRedErrorColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kGrayLightColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kGrayLightColor)),
      ),
    );
  }

  void _initTextController() {
    textController = TextEditingController(text: widget._initialValue);
    textController.addListener(() {
      _textHasChanged = true;
      _updateIsDirty();
      widget._onChanged?.call(textController.text);
    });
  }

  void _initFocusNode() {
    _focusNode.addListener(() {
      _updateFocusState();

      _updateIsDirty();

      if (!_focusNode.hasFocus) {
        _forceChangeText();
      }
    });
  }

  void _updateIsDirty() {
    _isDirty = _isDirty || (_textHasChanged && _hasLostFocus);
  }

  void _forceChangeText() {
    final currentText = textController.text;
    textController.text = " ";
    textController.clear();
    textController.text = currentText;
  }

  void _updateFocusState() {
    final currentlyHasFocus = _focusNode.hasFocus;

    _hasLostFocus =
        _hasLostFocus || (_previouslyHadFocus && !currentlyHasFocus);

    _previouslyHadFocus = currentlyHasFocus;
  }
}
