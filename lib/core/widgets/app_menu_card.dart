// core/widgets/app_menu_card.dart
import 'package:flutter/material.dart';
import 'package:reports_app/core/widgets/text_wedget.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

class AppMenuCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const AppMenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(isTablet ? 22 : 16),
        decoration: BoxDecoration(
          color: const Color(0xff1A1A1A),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.red.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.08),
              blurRadius: isTablet ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // ================= ICON =================
            Container(
              width: isTablet ? 50 : 30,
              height: isTablet ? 50 : 30,
              child: Image.asset('assets/images/$icon'),
              // child: Icon(
              //   icon,
              //   color: Colors.red,
              //   size: isTablet ? 28 : 22,
              // ),
            ),

            SizedBox(
              width: 10,
            ),

            // ================= TITLE =================
            Expanded(
              child: Center(
                child: AppText(
                  title:title
                ),
              ),
            ),

            // ================= ARROW =================
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white54,
              size: isTablet ? 20 : 16,
            ),
          ],
        ),
      ),
    );
  }
}