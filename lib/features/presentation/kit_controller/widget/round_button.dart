import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  final Color color;
  final Widget icon;

  const RoundButton({
    super.key,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.w,
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.h,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
