import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Premium minimal typography scale for the application design system.
abstract final class AppTextStyles {
  static const List<String> _fontFallback = <String>[
    'Inter',
    'Segoe UI',
    'Roboto',
    'Helvetica Neue',
    'Arial',
  ];

  // Display - for hero/large titles
  static const TextStyle display = TextStyle(
    fontSize: 32,
    height: 1.12,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: -0.5,
  );

  // Heading - for page titles
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: -0.3,
  );

  // Subheading - for section titles
  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    height: 1.25,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: -0.2,
  );

  // Body - for primary content
  static const TextStyle body = TextStyle(
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
  );

  // Body secondary - for supporting text
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamilyFallback: _fontFallback,
  );

  // Caption - for small labels and metadata
  static const TextStyle caption = TextStyle(
    fontSize: 13,
    height: 1.3,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: 0.1,
  );

  // Label - for badges and small UI labels
  static const TextStyle label = TextStyle(
    fontSize: 12,
    height: 1.2,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: 0.3,
  );

  // Button - for button text
  static const TextStyle button = TextStyle(
    fontSize: 15,
    height: 1.1,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: 0.1,
  );

  // Metric - for large numeric values
  static const TextStyle metric = TextStyle(
    fontSize: 30,
    height: 1.1,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: -0.3,
  );
}