import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';

class ButtonDescriptionWidget extends StatelessWidget {
  const ButtonDescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      color: kGrayColor,
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          const Text(
            'Explore More',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 100,
            color: kBlueGrayColor,
            child: const Center(
              child: Icon(Icons.favorite, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
