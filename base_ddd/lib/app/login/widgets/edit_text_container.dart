import 'package:base_ddd/config/values/colors.dart';
import 'package:flutter/material.dart';

class EditTextContainer extends StatelessWidget {
  const EditTextContainer({
    Key? key,
    required this.child,
    this.errorValidator = '',
  }) : super(key: key);

  final Widget child;
  final String errorValidator;

  static const double _marginVertical = 20.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (errorValidator.isEmpty)
          const SizedBox()
        else
          Padding(
            padding: const EdgeInsets.only(right: _marginVertical),
            child: SizedBox(
              child: Text(
                errorValidator,
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.red[300]),
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(bottom: 8, top: 4),
          padding: const EdgeInsets.symmetric(
              horizontal: _marginVertical, vertical: 3),
          decoration: BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: child,
        ),
      ],
    );
  }
}
