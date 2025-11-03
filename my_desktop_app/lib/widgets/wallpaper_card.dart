import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/wallpaper.dart';
import '../providers/favorites_provider.dart';
import '../widgets/safe_image.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class WallpaperCard extends StatelessWidget {
  final Wallpaper wallpaper;
  final VoidCallback onTap;

  const WallpaperCard({
    super.key,
    required this.wallpaper,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favProvider, _) {
        final isFavorite = favProvider.isFavorite(wallpaper.id);

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  SafeImage(
                    imageUrl: wallpaper.imageUrl,
                    fit: BoxFit.cover,
                  ),

                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: InkWell(
                      onTap: () => favProvider.toggleFavorite(wallpaper),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          size: 20,
                          color: isFavorite
                              ? AppColors.primaryOrange
                              : AppColors.textGray,
                        ),
                      ),
                    ),
                  ),

                  // Title and category
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            wallpaper.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              wallpaper.category,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
