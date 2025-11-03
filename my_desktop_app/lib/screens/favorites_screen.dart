import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
// import '../providers/wallpaper_provider.dart';
import '../widgets/wallpaper_card.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/dummy_data.dart';
import 'wallpaper_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, provider, _) {
        final hasFavorites = provider.favorites.isNotEmpty;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppConstants.paddingLarge),

                // Header
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.headerGradient.createShader(bounds),
                  child: const Text(
                    'Saved Wallpapers',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your saved wallpapers collection',
                  style: TextStyle(fontSize: 16, color: AppColors.textGray),
                ),

                const SizedBox(height: AppConstants.paddingXLarge),

                // Content
                hasFavorites
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: AppConstants.gridSpacing,
                          mainAxisSpacing: AppConstants.gridSpacing,
                        ),
                        itemCount: provider.favorites.length,
                        itemBuilder: (context, index) {
                          final wallpaper = provider.favorites[index];
                          final category = DummyData.getCategoryByName(
                            wallpaper.category,
                          );

                          return WallpaperCard(
                            wallpaper: wallpaper,
                            onTap: () {
                              if (category != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WallpaperDetailScreen(
                                      wallpaper: wallpaper,
                                      category: category,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      )
                    : _EmptyFavorites(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),

          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: AppColors.backgroundLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              size: 60,
              color: AppColors.textGray.withOpacity(0.5),
            ),
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          const Text(
            'No Saved Wallpapers',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Start saving your favorite wallpapers to see them here',
            style: TextStyle(fontSize: 14, color: AppColors.textGray),
          ),

          const SizedBox(height: AppConstants.paddingLarge),

          ElevatedButton(
            onPressed: () {
              // This would normally switch to browse tab
              // For now, just show a message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigate to Browse to find wallpapers'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              backgroundColor: AppColors.primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
            ),
            child: const Text(
              'Browse Wallpapers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
