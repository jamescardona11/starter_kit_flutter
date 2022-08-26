import 'package:flutter/material.dart';

import 'responsive_extension.dart';

const double kSizeHeaderBar = 65;
const double kSpaceMax = 100;
const double kSpaceBig = 50;
const double kSpaceMedium = 30;
const double kSpaceSmall = 15;
const double kSpaceLittle = 5;

const kSpaceMaxVertical = SizedBox(height: kSpaceMax);
const kSpaceBigVertical = SizedBox(height: kSpaceBig);
const kSpaceMediumVertical = SizedBox(height: kSpaceMedium);
const kSpaceSmallVertical = SizedBox(height: kSpaceSmall);
const kSpaceLittleVertical = SizedBox(height: kSpaceLittle);

const kSpaceBigHorizontal = SizedBox(width: kSpaceBig);
const kSpaceMediumHorizontal = SizedBox(width: kSpaceMedium);
const kSpaceSmallHorizontal = SizedBox(width: kSpaceSmall);
const kSpaceLittleHorizontal = SizedBox(width: kSpaceLittle);

// Radius
const radiusNormal = Radius.circular(25);
const borderRadiusNormal = BorderRadius.all(radiusNormal);

EdgeInsets getPaddingMainPages(BuildContext context) => EdgeInsets.symmetric(
      vertical: context.heightPct(5),
      horizontal: context.widthPct(10),
    );

EdgeInsets getHorizontalPaddingMainPages(BuildContext context) =>
    EdgeInsets.symmetric(horizontal: context.widthPct(2));
