import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';
import '../widgets/category_card.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'category_detail_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<WallpaperProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ REDUCED TOP SPACING (was paddingLarge = 24, now 16)
                const SizedBox(height: 16), // 👈 PUSHED UP

                // Header with view toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.headerGradient.createShader(bounds),
                      child: const Text(
                        'Browse Categories',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),

                    // View toggle
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _isGridView
                                ? AppColors.backgroundLight
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isGridView = true;
                              });
                            },
                            icon: Icon(
                              Icons.grid_view_rounded,
                              color: _isGridView
                                  ? AppColors.primaryOrange
                                  : AppColors.textGray,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: !_isGridView
                                ? AppColors.backgroundLight
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isGridView = false;
                              });
                            },
                            icon: Icon(
                              Icons.view_list_rounded,
                              color: !_isGridView
                                  ? AppColors.primaryOrange
                                  : AppColors.textGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Subtitle
                const Text(
                  'Explore our curated collections of stunning wallpapers',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGray,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: AppConstants.paddingXLarge),

                // Categories
                _isGridView
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: AppConstants.gridSpacing,
                          mainAxisSpacing: AppConstants.gridSpacing,
                        ),
                        itemCount: provider.categories.length,
                        itemBuilder: (context, index) {
                          final category = provider.categories[index];
                          return CategoryCard(
                            category: category,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetailScreen(
                                    category: category,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.categories.length,
                        itemBuilder: (context, index) {
                          final category = provider.categories[index];
                          return _CategoryListItem(
                            category: category,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetailScreen(
                                    category: category,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryListItem extends StatelessWidget {
  final category;
  final VoidCallback onTap;

  const _CategoryListItem({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                image: DecorationImage(
                  image: AssetImage(category.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: AppConstants.paddingLarge),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textGray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${category.wallpaperCount} wallpapers',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
