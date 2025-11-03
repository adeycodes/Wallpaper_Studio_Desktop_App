import 'package:flutter/material.dart';
import '../utils/colors.dart';

/// A widget that safely loads images with fallback to placeholder
class SafeImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;

  const SafeImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        // Return placeholder when image fails to load
        return placeholder ?? _DefaultPlaceholder(width: width, height: height);
      },
    );
  }
}

class _DefaultPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;

  const _DefaultPlaceholder({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.backgroundLight,
            AppColors.background,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              size: 48,
              color: AppColors.textGray.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'Image not found',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textGray.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
