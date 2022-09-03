import 'package:flutter/material.dart';
import 'package:reusable_ui_flutter/config/config.dart';

import 'circular_icon_background.dart';

class ManagementView extends StatelessWidget {
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
              image: AssetsManager.imgManagement,
              icon: Icons.manage_accounts,
            ),
            kSpaceBigVertical,
            kSpaceBigVertical,
            Text(
              'Management',
              style: textTheme.headline1,
            ),
            kSpaceBigVertical,
            Text(
              'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
              textAlign: TextAlign.center,
              style: textTheme.headline2!.copyWith(
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
