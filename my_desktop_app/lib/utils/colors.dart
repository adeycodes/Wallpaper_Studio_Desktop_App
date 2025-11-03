import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (from Figma)
  static const Color primaryOrange = Color.fromRGBO(255, 167, 38, 1);
  static const Color primaryOrangeDark = Color(0xFFFF8C42);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGray = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Gradient Colors (exact from design)
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFBB03B), Color(0xFFFF6B6B)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFFBB03B), Color(0xFFFF8C42), Color(0xFFFF6B6B)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Accent Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color error = Color(0xFFEF4444);

  // Card & Border
  static const Color cardBorder = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFE5E7EB);

  // Overlay
  static Color overlayDark = Colors.black.withOpacity(0.3);
  static Color overlayGradient = Colors.black.withOpacity(0.7);
}
