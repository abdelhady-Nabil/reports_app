import 'package:flutter/material.dart';
import 'package:reports_app/core/widgets/text_wedget.dart';

class AppPrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoading,
  });

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton>
    with SingleTickerProviderStateMixin {

  double scale = 1;

  void onTapDown(_) => setState(() => scale = 0.96);
  void onTapUp(_) => setState(() => scale = 1);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: scale,
      child: GestureDetector(
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onTapCancel: () => setState(() => scale = 1),

        // 🔥 مهم: امنع الضغط أثناء التحميل
        onTap: widget.isLoading ? null : widget.onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xffFF3B3B), Color(0xffD90429)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Center(
            child: widget.isLoading
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(Icons.bar_chart_rounded, color: Colors.white,size: 30,),
                SizedBox(width: 10),
                AppText(title: widget.text),

              ],
            ),
          ),
        ),
      ),
    );
  }
}