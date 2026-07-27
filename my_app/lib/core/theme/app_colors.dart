import 'package:flutter/material.dart';

/// Premium minimal color palette for the malware classification application.
abstract final class AppColors {
  // Primary palette
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryMuted = Color(0xFF1E3A5F);

  // Background layers
  static const Color background = Color(0xFF0F1117);
  static const Color surface = Color(0xFF1A1D27);
  static const Color surfaceElevated = Color(0xFF22252F);
  static const Color surfaceSoft = Color(0xFF2A2D38);

  // Semantic colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFEAB308);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Text colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Border and separator
  static const Color divider = Color(0xFF2E3241);

  // Overlay
  static const Color overlay = Color(0xCC0F1117);

  // Shimmer
  static const Color shimmerBase = Color(0xFF1E2230);
  static const Color shimmerHighlight = Color(0xFF2A2F3E);
}