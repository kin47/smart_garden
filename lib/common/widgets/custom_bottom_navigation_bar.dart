import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/common/app_theme/app_colors.dart';
import 'package:smart_garden/common/app_theme/app_text_styles.dart';
import 'package:smart_garden/features/domain/entity/bottom_nav_bar_item_entity.dart';
import 'package:smart_garden/features/domain/enum/core_tab.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final CoreTab activeTab;
  final List<BottomNavBarItemEntity> items;
  final Color? backgroundColor;
  final Function(
    BottomNavBarItemEntity item,
  ) onClickBottomBar;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    this.backgroundColor,
    required this.onClickBottomBar,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 140.h,
          width: 1.sw,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: AppColors.white,
            width: 1.sw,
            height: 100.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map(
                    (e) => Expanded(
                      child: ItemBottomNavigation(
                        isActive: e.type == activeTab,
                        item: e,
                        onPressed: () {
                          onClickBottomBar(e);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 1.sw / 6,
              width: 1.sw / 6,
              decoration: BoxDecoration(
                color: AppColors.primary700,
                borderRadius: BorderRadius.circular(1.sw / 12),
              ),
              child: Icon(
                Icons.qr_code_scanner,
                size: 1.sw / 12,
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ItemBottomNavigation extends StatelessWidget {
  final BottomNavBarItemEntity item;
  final Function() onPressed;
  final bool isActive;

  const ItemBottomNavigation({
    Key? key,
    required this.item,
    required this.onPressed,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            item.type.icon(isActive),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: Text(
                item.type.bottomNavTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.s14w400.copyWith(
                  color: isActive ? AppColors.primary500 : AppColors.gray200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
