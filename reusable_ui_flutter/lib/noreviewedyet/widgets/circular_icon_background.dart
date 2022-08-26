import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/colors.dart';
import 'package:reusable_ui_flutter/responsive_extension.dart';

class CircularIconBackground extends StatelessWidget {
  final String image;
  final IconData icon;

  const CircularIconBackground({
    Key? key,
    required this.image,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthPx - 30,
      height: context.widthPx - 30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            radius: context.widthPx / 2.5,
            backgroundColor: Colors.black12.withOpacity(0.1),
            child: CircleAvatar(
              radius: context.widthPx / 3.2,
              backgroundColor: Colors.black12.withOpacity(0.1),
              child: Center(
                child: Image.asset(
                  image,
                  width: 120,
                  color: kBlueLightColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: kWhiteColor,
              child: Center(
                child: Icon(
                  icon,
                  color: kBlueLightColor,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
