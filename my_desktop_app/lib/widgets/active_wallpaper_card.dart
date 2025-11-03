import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../widgets/safe_image.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class ActiveWallpaperCard extends StatelessWidget {
  final Wallpaper wallpaper;
  final VoidCallback onShareTap;
  final VoidCallback onSettingsTap;

  const ActiveWallpaperCard({
    super.key,
    required this.wallpaper,
    required this.onShareTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingMedium,
      ),
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Wallpaper thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            child: SizedBox(
              width: 100,
              height: 100,
              child: SafeImage(
                imageUrl: wallpaper.imageUrl,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),

          const SizedBox(width: AppConstants.paddingLarge),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.headerGradient.createShader(bounds),
                  child: const Text(
                    'Your Active Wallpaper',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'This wallpaper is currently set as your active background',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textGray,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Category - ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textGray,
                      ),
                    ),
                    Text(
                      wallpaper.category,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Selection - ',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textGray,
                      ),
                    ),
                    Text(
                      wallpaper.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action buttons
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.cardBorder),
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            child: IconButton(
              onPressed: onShareTap,
              icon: const Icon(Icons.share_outlined, size: 20),
              color: AppColors.textGray,
              tooltip: 'Share',
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.cardBorder),
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            child: IconButton(
              onPressed: onSettingsTap,
              icon: const Icon(Icons.settings_outlined, size: 20),
              color: AppColors.textGray,
              tooltip: 'Settings',
            ),
          ),
        ],
      ),
    );
  }
}
