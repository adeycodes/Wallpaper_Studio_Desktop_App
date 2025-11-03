import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WallpaperProvider>(
      builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Settings Card
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusLarge),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    padding: const EdgeInsets.all(AppConstants.paddingXLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.headerGradient.createShader(bounds),
                          child: const Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Customize your Wallpaper Studio experience',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textGray,
                          ),
                        ),

                        const SizedBox(height: AppConstants.paddingXLarge),

                        // Wallpaper Setup Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Wallpaper Setup',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Configure your wallpaper settings and enable auto-rotation',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textGray,
                              ),
                            ),

                            const SizedBox(height: AppConstants.paddingLarge),

                            // Image Quality
                            const Text(
                              'Image Quality',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.cardBorder),
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMedium,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: provider.imageQuality,
                                isExpanded: true,
                                underline: const SizedBox(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: AppConstants.imageQualities.map((
                                  quality,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: quality,
                                    child: Text(quality),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    provider.setImageQuality(value);
                                  }
                                },
                              ),
                            ),

                            const SizedBox(height: AppConstants.paddingLarge),

                            // Notification Toggle
                            _SettingToggle(
                              title: 'Notification',
                              description:
                                  'Get notified about new wallpapers and updates',
                              value: provider.notificationsEnabled,
                              onChanged: (value) {
                                provider.toggleNotifications(value);
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: AppConstants.paddingLarge),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Settings cancelled'),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.radiusMedium,
                                    ),
                                  ),
                                  side: const BorderSide(
                                    color: AppColors.cardBorder,
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppConstants.paddingMedium),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  provider.saveSettings();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Settings saved successfully',
                                      ),
                                      backgroundColor: AppColors.success,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  backgroundColor: AppColors.primaryOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.radiusMedium,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Save Settings',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: AppConstants.paddingXLarge),

                // Right: Phone Preview (same height as settings card)
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      width: 280,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Stack(
                          children: [
                            // Phone body
                            Container(
                              height: 580, // Match your design's phone height
                              decoration: BoxDecoration(
                                color: AppColors.textDark,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: AppColors.textDark,
                                  width: 8,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: Stack(
                                  children: [
                                    // Screen background
                                    Container(
                                      color: Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: const BoxDecoration(
                                                color: AppColors.success,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.link,
                                                size: 32,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            const Text(
                                              'Connected to device',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'Click to disconnect',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.textGray,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Notch
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          width: 120,
                                          height: 28,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Bottom indicator
                                    Positioned(
                                      bottom: 8,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          width: 120,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
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

class _SettingToggle extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingToggle({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style:
                      const TextStyle(fontSize: 12, color: AppColors.textGray),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primaryOrange,
          ),
        ],
      ),
    );
  }
}
