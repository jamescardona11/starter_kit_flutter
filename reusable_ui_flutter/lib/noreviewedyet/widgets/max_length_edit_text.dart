import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';
import 'package:reusable_ui_flutter/noreviewedyet/widgets/edit_text_container.dart';

class MaxLengthEditText extends StatelessWidget {
  final int maxLines;
  final int maxLength;
  final ValueChanged<String>? onChanged;

  const MaxLengthEditText({
    Key? key,
    required this.maxLines,
    required this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EditTextContainer(
      paddingHorizontal: 20,
      paddingVertical: 3,
      height: 100,
      width: 200,
      child: TextFormField(
        cursorColor: kPrimaryColor,
        autocorrect: false,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged ?? (_) {},
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
