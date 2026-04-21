import 'package:flutter/material.dart';

import '../../helper/responsive_helper.dart';

class AppText extends StatelessWidget {
  final String title;
  final Color color;


  const AppText({
    super.key,
    required this.title,
    this.color=Colors.white
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return  Text(
      maxLines: 1,
      title,
      style: TextStyle(
        color: color,
        fontSize: isTablet ? 35 : 25,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis
      ),
    );
  }
}