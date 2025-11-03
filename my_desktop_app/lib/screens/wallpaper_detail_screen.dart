import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/wallpaper.dart';
import '../models/category.dart';
import '../providers/wallpaper_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/preview_phone_widget.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class WallpaperDetailScreen extends StatelessWidget {
  final Wallpaper wallpaper;
  final Category category;

  const WallpaperDetailScreen({
    super.key,
    required this.wallpaper,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side - Wallpaper grid
          Expanded(
            flex: 3,
            child: _WallpaperGridSection(
              category: category,
              currentWallpaper: wallpaper,
            ),
          ),

          // Right side - Preview and details
          Expanded(
            flex: 3,
            child: Container(
              color: AppColors.backgroundLight,
              child: _PreviewSection(wallpaper: wallpaper),
            ),
          ),
        ],
      ),
    );
  }
}

class _WallpaperGridSection extends StatelessWidget {
  final Category category;
  final Wallpaper currentWallpaper;

  const _WallpaperGridSection({
    required this.category,
    required this.currentWallpaper,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WallpaperProvider>(
      builder: (context, provider, _) {
        final wallpapers = provider.getWallpapersByCategory(category.name);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Back to Categories (now fully tappable)
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.arrow_back,
                          color: AppColors.textGray, size: 20),
                    ),
                    const SizedBox(width: AppConstants.paddingMedium),
                    const Text(
                      'Back to Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingLarge,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.grid_view_rounded,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.view_list_rounded,
                          color: AppColors.textGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.paddingLarge),

            // Wallpapers grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLarge,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: AppConstants.paddingMedium,
                  mainAxisSpacing: AppConstants.paddingMedium,
                ),
                itemCount: wallpapers.length,
                itemBuilder: (context, index) {
                  final wp = wallpapers[index];
                  final isSelected = wp.id == currentWallpaper.id;

                  return _WallpaperGridItem(
                    wallpaper: wp,
                    isSelected: isSelected,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WallpaperDetailScreen(
                            wallpaper: wp,
                            category: category,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _WallpaperGridItem extends StatelessWidget {
  final Wallpaper wallpaper;
  final bool isSelected;
  final VoidCallback onTap;

  const _WallpaperGridItem({
    required this.wallpaper,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, _) {
        final isFavorite = favProvider.isFavorite(wallpaper.id);

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              image: DecorationImage(
                image: AssetImage(wallpaper.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusMedium,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () => favProvider.toggleFavorite(wallpaper),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        size: 16,
                        color: isFavorite
                            ? AppColors.primaryOrange
                            : AppColors.textGray,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wallpaper.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          wallpaper.category,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PreviewSection extends StatelessWidget {
  final Wallpaper wallpaper;

  const _PreviewSection({required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Preview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: AppConstants.paddingXLarge),

          // Layout for preview section (details on left, phone on right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Details section (left)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.paddingLarge),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.circular(AppConstants.radiusLarge),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.textGray),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        wallpaper.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: AppConstants.paddingMedium),
                      const Text(
                        'Tags',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.textGray),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: wallpaper.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textDark,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppConstants.paddingMedium),
                      const Text(
                        'Description',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.textGray),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        wallpaper.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textGray,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: AppConstants.paddingMedium),

                      // Action icons
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Share functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Share feature coming soon'),
                                ),
                              );
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.backgroundLight,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.upload_outlined, size: 20),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              // Edit functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Edit feature coming soon'),
                                ),
                              );
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.backgroundLight,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.edit_outlined, size: 20),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              // Settings functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Settings feature coming soon'),
                                ),
                              );
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.backgroundLight,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.settings_outlined, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: AppConstants.paddingXLarge),

              // Phone preview (right)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                ),
                child: PreviewPhoneWidget(wallpaper: wallpaper),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          // Action buttons
          Consumer2<WallpaperProvider, FavoritesProvider>(
            builder: (context, wallProvider, favProvider, _) {
              final isFavorite = favProvider.isFavorite(wallpaper.id);

              return Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => favProvider.toggleFavorite(wallpaper),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.cardBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusMedium,
                          ),
                        ),
                      ),
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite
                            ? AppColors.primaryOrange
                            : AppColors.textDark,
                      ),
                      label: Text(
                        isFavorite ? 'Saved' : 'Save to Favorites',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        wallProvider.setActiveWallpaper(wallpaper);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${wallpaper.name} set as wallpaper'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.primaryOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusMedium,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Set to Wallpaper',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
