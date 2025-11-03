import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallpaper_provider.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class WallpaperSetupModal extends StatefulWidget {
  const WallpaperSetupModal({super.key});

  @override
  State<WallpaperSetupModal> createState() => _WallpaperSetupModalState();
}

class _WallpaperSetupModalState extends State<WallpaperSetupModal> {
  late String selectedDisplayMode;
  late bool autoRotation;
  late bool lockWallpaper;
  late bool syncAcrossDevices;

  @override
  void initState() {
    super.initState();
    final provider = context.read<WallpaperProvider>();
    selectedDisplayMode = provider.displayMode;
    autoRotation = provider.autoRotation;
    lockWallpaper = provider.lockWallpaper;
    syncAcrossDevices = provider.syncAcrossDevices;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppConstants.radiusLarge),
            bottomLeft: Radius.circular(AppConstants.radiusLarge),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Scrollable content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.paddingXLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Wallpaper Setup',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Configure your wallpaper settings and enable auto-rotation',
                      style: TextStyle(fontSize: 14, color: AppColors.textGray),
                    ),

                    const SizedBox(height: AppConstants.paddingXLarge),

                    // Activate Wallpaper - FIXED: Checkmark INSIDE "Activated" pill
                    Container(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusMedium),
                        border: Border.all(
                            color: AppColors.success.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          // Left side: Icon + Title + Description
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Activate Wallpaper',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Set the selected wallpaper as your desktop background',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Right side: Green "Activated" pill with checkmark inside
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Activated',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppConstants.paddingLarge),

                    // Display mode (fixed typo)
                    const Text(
                      'Display mode',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),

                    ...AppConstants.displayModes.map((mode) {
                      return _DisplayModeOption(
                        mode: mode,
                        description: _getDisplayModeDescription(mode),
                        isSelected: selectedDisplayMode == mode,
                        onTap: () {
                          setState(() {
                            selectedDisplayMode = mode;
                          });
                        },
                      );
                    }),

                    const SizedBox(height: AppConstants.paddingLarge),

                    // Auto-Rotation
                    _ToggleOption(
                      title: 'Auto - Rotation',
                      description:
                          'Automatically change your wallpaper at regular intervals',
                      value: autoRotation,
                      onChanged: (value) {
                        setState(() {
                          autoRotation = value;
                        });
                      },
                    ),

                    const SizedBox(height: AppConstants.paddingLarge),

                    // Advanced Settings
                    const Text(
                      'Advanced Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),

                    _CheckboxOption(
                      title: 'Lock Wallpaper',
                      description: 'Prevent accidental changes',
                      value: lockWallpaper,
                      onChanged: (value) {
                        setState(() {
                          lockWallpaper = value ?? false;
                        });
                      },
                    ),

                    _CheckboxOption(
                      title: 'Sync Across Devices',
                      description: 'Keep wallpaper consistent on all devices',
                      value: syncAcrossDevices,
                      onChanged: (value) {
                        setState(() {
                          syncAcrossDevices = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Fixed action buttons at bottom
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstants.paddingXLarge,
                right: AppConstants.paddingXLarge,
                bottom: AppConstants.paddingXLarge,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusMedium,
                          ),
                        ),
                        side: const BorderSide(color: AppColors.cardBorder),
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
                        final provider = context.read<WallpaperProvider>();
                        provider.setDisplayMode(selectedDisplayMode);
                        provider.toggleAutoRotation(autoRotation);
                        provider.toggleLockWallpaper(lockWallpaper);
                        provider.toggleSyncAcrossDevices(syncAcrossDevices);
                        provider.saveSettings();
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Settings saved successfully'),
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
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayModeDescription(String mode) {
    switch (mode) {
      case 'Fit':
        return 'Scale to fit without cropping';
      case 'Fill':
        return 'Scale to fill the entire screen';
      case 'Stretch':
        return 'Stretch to fill the screen';
      case 'Tile':
        return 'Repeat the image to fill the screen';
      default:
        return '';
    }
  }
}

// Keep your existing widgets unchanged — they are correct
class _DisplayModeOption extends StatelessWidget {
  final String mode;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _DisplayModeOption({
    required this.mode,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : AppColors.cardBorder,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSelected ? AppColors.primaryOrange : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryOrange
                      : AppColors.cardBorder,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textGray),
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

class _ToggleOption extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleOption({
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

class _CheckboxOption extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _CheckboxOption({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryOrange,
          ),
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
                Text(
                  description,
                  style:
                      const TextStyle(fontSize: 12, color: AppColors.textGray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
