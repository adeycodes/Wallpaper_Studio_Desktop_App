import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../widgets/safe_image.dart';
import '../utils/colors.dart';

class PreviewPhoneWidget extends StatelessWidget {
  final Wallpaper wallpaper;

  const PreviewPhoneWidget({
    super.key,
    required this.wallpaper,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.textDark,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: AppColors.textDark,
          width: 8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Wallpaper
            SafeImage(
              imageUrl: wallpaper.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Notch (Dynamic Island style)
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

            // Bottom indicator (Home Gesture Bar)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
