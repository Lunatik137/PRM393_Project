import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // Brand colors
  static const Color primary = Color(0xFF9A7865);
  static const Color primaryDark = Color(0xFF765847);
  static const Color primaryLight = Color(0xFFD8C2B5);

  static const Color secondary = Color(0xFFD8B4A0);
  static const Color sage = Color(0xFFB8C5AE);
  static const Color lightBlue = Color(0xFFB9CAD6);

  // Background and surface
  static const Color background = Color(0xFFFAF7F2);
  static const Color surface = Color(0xFFF4EFE7);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFEDE8E3);

  // Text
  static const Color textPrimary = Color(0xFF3F3A37);
  static const Color textSecondary = Color(0xFF756D68);
  static const Color textDisabled = Color(0xFFA9A19C);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border and divider
  static const Color border = Color(0xFFE8E0D8);
  static const Color divider = Color(0xFFEDE6DF);

  // Status colors
  static const Color success = Color(0xFF71856A);
  static const Color successBackground = Color(0xFFE7EEE2);

  static const Color warning = Color(0xFFA67C52);
  static const Color warningBackground = Color(0xFFF5ECDD);

  static const Color danger = Color(0xFFD64C4C);
  static const Color dangerBackground = Color(0xFFF9E5E5);

  static const Color info = Color(0xFF6D8999);
  static const Color infoBackground = Color(0xFFE5EEF2);

  // Visibility
  static const Color publicBadgeBackground = successBackground;
  static const Color publicBadgeForeground = success;

  static const Color privateBadgeBackground = surfaceMuted;
  static const Color privateBadgeForeground = textSecondary;

  // Overlay and shadow
  static const Color overlay = Color(0x66000000);
  static const Color shadow = Color(0x1A4D3A30);

  // Transparent
  static const Color transparent = Colors.transparent;
}
