// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

// extension based from argo-library
// {@template responsive_extension}
//
//
// Extension to bring the information in a easier way for the responsive.
// All calculations related whit `MediaQuery.of(context).size`
//
// ```dart
// context.isLandscape;
// context.widthPct(10);
// context.heightPx;
// ...
// ```
//
// {@endtemplate}
extension ResponsiveContext on BuildContext {
  // Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  // Returns if Orientation is landscape
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  // Returns same as MediaQuery.of(context).size
  Size get sizePx => MediaQuery.of(this).size;

  // Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  // Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  // Returns diagonal screen pixels
  double get diagonalPx {
    final Size s = sizePx;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  // Returns percent (1-100) of screen width in pixels
  double widthPct(double percent) => percent * widthPx / 100;

  // Returns percent (1-100) of screen height in pixels
  double heightPct(double percent) => percent * heightPx / 100;

  // Extension for getting Theme
  ThemeData get theme => Theme.of(this);

  // Extension for getting textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Return custom AppSizes
  // AppSizes get appSizes => Theme.of(this).extension<AppSizes>()!;

  // Return custom AppColors
  // AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
