import 'package:flutter/material.dart';
import 'package:reports_app/core/widgets/text_wedget.dart';

import '../../../helper/responsive_helper.dart';

class RatingItem extends StatelessWidget {
  final String title;
  final double value;
  final Function(double) onChanged;

  const RatingItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(AppSizes.padding(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(AppSizes.cardRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 20 : 10,
          ),
        ],
      ),
      child: Column(
        children: [

          // ================= TITLE + VALUE =================
          Row(
            children: [
              Icon(Icons.analytics_outlined,
                  size: AppSizes.icon(context),
                  color: Colors.red,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: AppText(title: title,color: Colors.black,),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 14 : 10,
                  vertical: isTablet ? 6 : 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(title: value.toStringAsFixed(1),color: Colors.red,),

              ),
            ],
          ),

          const SizedBox(height: 10),

          // ================= SLIDER =================
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: isTablet ? 12 : 8,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: isTablet ? 20 : 14,
              ),
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.red.withOpacity(0.2),
              thumbColor: Colors.red,
            ),
            child: Slider(
              value: value,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}