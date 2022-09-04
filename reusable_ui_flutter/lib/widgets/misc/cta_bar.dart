import 'package:flutter/material.dart';

import '../buttons/eleventh_button_widget.dart';

class CTABar extends StatelessWidget {
  const CTABar({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 15,
            color: Colors.grey.shade400,
          ),
        ],
      ),
      child: SizedBox(
        width: size.width,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 50,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.shop,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: EleventhButton(
                  label: label,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  radius: 40,
                  primaryColor: Colors.amber,
                  accentColor: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
