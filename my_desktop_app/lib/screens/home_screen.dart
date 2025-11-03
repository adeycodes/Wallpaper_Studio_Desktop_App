import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/active_wallpaper_card.dart';
import '../widgets/category_card.dart';
import '../widgets/wallpaper_setup_modal.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'browse_screen.dart';
import 'category_detail_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return const _HomeContent();
      case 1:
        return const BrowseScreen();
      case 2:
        return const FavoritesScreen();
      case 3:
        return const SettingsScreen();
      default:
        return const _HomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onNavigationTap,
          ),
          Expanded(
            child: _getCurrentScreen(),
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<WallpaperProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstants.paddingLarge),

              // Header - "Discover Beautiful Wallpapers"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.headerGradient.createShader(bounds),
                      child: const Text(
                        'Discover Beautiful Wallpapers',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Discover curated collections of stunning wallpapers. Browse by\ncategory, preview in full-screen, and set your favorites.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textGray,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.paddingXLarge),

              // Active Wallpaper Card (if wallpaper is set)
              if (provider.activeWallpaper != null)
                ActiveWallpaperCard(
                  wallpaper: provider.activeWallpaper!,
                  onShareTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share feature coming soon'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  onSettingsTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.5),
                      builder: (context) => const Dialog(
                        alignment: Alignment.centerRight,
                        insetPadding: EdgeInsets.zero,
                        child: WallpaperSetupModal(),
                      ),
                    );
                  },
                ),

              const SizedBox(height: AppConstants.paddingXLarge),

              // Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLarge,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to browse screen would go here
                        // For now it's handled by the navigation bar
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textGray,
                      ),
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppConstants.paddingLarge),

              // Categories Grid
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLarge,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                ),
              ),

              const SizedBox(height: AppConstants.paddingXLarge),
            ],
          ),
        );
      },
    );
  }
}
