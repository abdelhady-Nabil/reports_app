// core/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import '../../helper/responsive_helper.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle title(BuildContext context) => TextStyle(
    fontSize: Responsive.isTablet(context) ? 22 : 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: Responsive.isTablet(context) ? 16 : 13,
    color: AppColors.textSecondary,
  );

  static TextStyle button(BuildContext context) => TextStyle(
    fontSize: Responsive.isTablet(context) ? 16 : 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}