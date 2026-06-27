import 'package:flutter/material.dart';

import '../../../../resources/app_colors.dart';
import '../../../../resources/app_fonts.dart';

/// Item metadata for CustomBottomNavBar.
class CustomBottomNavBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const CustomBottomNavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

/// Floating animated navigation bar matching modern premium aesthetics.
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<CustomBottomNavBarItem> items;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color(0xFF101729).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          // ignore: deprecated_member_use
          color: AppColors.line.withOpacity(0.6),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 18 : 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    // ignore: deprecated_member_use
                    ? AppColors.primary.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? items[index].activeIcon : items[index].icon,
                    color: isSelected ? AppColors.primary : Colors.grey[500],
                    size: 22,
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: isSelected
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              Text(
                                items[index].label,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.5,
                                  fontFamily: AppFonts.primaryFont,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
