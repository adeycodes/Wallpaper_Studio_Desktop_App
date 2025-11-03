import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.navBarHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  gradient: AppColors.orangeGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.asset(
                  'assets/icons/wallpaper_logo.png',
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                  color: Colors.white, // Optional: if image is grayscale/white
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Wallpaper Studio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Navigation Items
          Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              const SizedBox(width: 8),
              _NavItem(
                icon: Icons.grid_view_outlined,
                label: 'Browse',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              const SizedBox(width: 8),
              _NavItem(
                icon: Icons.favorite_outline,
                label: 'Favourites',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              const SizedBox(width: 8),
              _NavItem(
                icon: Icons.settings_outlined,
                label: 'Settings',
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.backgroundLight : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColors.textDark : AppColors.textGray,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.textDark : AppColors.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
