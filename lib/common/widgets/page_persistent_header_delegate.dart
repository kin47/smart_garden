import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagePersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double? customMaxExtent;
  final double? customMinExtent;
  final Color backgroundColor;
  PagePersistentHeaderDelegate({
    required this.child,
    this.customMaxExtent,
    this.customMinExtent,
    this.backgroundColor = Colors.blue,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => customMaxExtent ?? 80.h;

  @override
  double get minExtent => customMinExtent ?? 50.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
