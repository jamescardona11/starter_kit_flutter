import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';
import 'circular_icon_background.dart';

class StepsView extends StatelessWidget {
  const StepsView({
    Key? key,
    required this.title,
    required this.description,
    required this.imageAssets,
    required this.iconData,
  }) : super(key: key);

  final String title;
  final String description;
  final String imageAssets;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpaceMedium + 5),
        child: Column(
          children: [
            const SizedBox(height: 50),
            CircularIconBackground(
              image: imageAssets,
              icon: iconData,
            ),
            kSpaceBigVertical,
            kSpaceBigVertical,
            Text(
              title,
              style: GoogleFonts.notoSans(
                fontSize: 28,
                color: Colors.grey,
                fontWeight: FontWeight.w800,
              ),
              // style: TextStyle(
              //   fontSize: 28,
              //   color: Colors.grey,
              // ),
            ),
            kSpaceBigVertical,
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.monda(
                fontSize: 16,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w300,
              ),
              // style: TextStyle(
              //   fontSize: 16,
              //   color: Colors.grey.shade400,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
