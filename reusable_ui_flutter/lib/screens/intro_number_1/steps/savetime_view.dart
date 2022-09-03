import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/config/config.dart';

import 'circular_icon_background.dart';

class SaveTimeView extends StatelessWidget {
  const SaveTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpaceMedium + 5),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const CircularIconBackground(
              image: AssetsManager.imgSavetime,
              icon: Icons.access_time_filled_rounded,
            ),
            kSpaceBigVertical,
            kSpaceBigVertical,
            Text(
              'Save time',
              style: textTheme.headline1!.copyWith(
                fontSize: 28,
                color: Colors.grey,
              ),
            ),
            kSpaceBigVertical,
            Text(
              'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
              textAlign: TextAlign.center,
              style: textTheme.headline2!.copyWith(
                fontSize: 16,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
