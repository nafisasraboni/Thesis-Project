import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Shared text styles aligned to the product design system.
abstract final class AppTextStyles {
  static const List<String> _fontFallback = <String>[
    'Segoe UI',
    'Roboto',
    'Arial',
  ];

  static const TextStyle display = TextStyle(
    fontSize: 30,
    height: 1.15,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: -0.3,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 22,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    height: 1.25,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamilyFallback: _fontFallback,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    fontFamilyFallback: _fontFallback,
    letterSpacing: 0.2,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    height: 1.1,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
  );

  static const TextStyle metric = TextStyle(
    fontSize: 28,
    height: 1.1,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: _fontFallback,
  );
}
