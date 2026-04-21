import 'package:flutter/material.dart';

class Responsive {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
}

class AppSizes {
  static double padding(BuildContext context) =>
      Responsive.isTablet(context) ? 24 : 16;

  static double text(BuildContext context) =>
      Responsive.isTablet(context) ? 18 : 14;

  static double title(BuildContext context) =>
      Responsive.isTablet(context) ? 22 : 16;

  static double icon(BuildContext context) =>
      Responsive.isTablet(context) ? 28 : 20;

  static double cardRadius(BuildContext context) =>
      Responsive.isTablet(context) ? 20 : 14;
}