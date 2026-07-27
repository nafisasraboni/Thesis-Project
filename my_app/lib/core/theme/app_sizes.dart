import 'package:flutter/widgets.dart';

/// Premium minimal spacing, radius, sizing, and breakpoint tokens.
abstract final class AppSizes {
  // Spacing scale
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  // Border radius
  static const double radiusXs = 6;
  static const double radiusSm = 10;
  static const double radiusMd = 14;
  static const double radiusLg = 18;
  static const double radiusXl = 24;

  // Icon sizes
  static const double iconXs = 14;
  static const double iconSm = 18;
  static const double iconMd = 22;
  static const double iconLg = 28;
  static const double iconXl = 36;

  // Breakpoints
  static const double mobileBreakpoint = 480;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1200;
  static const double contentMaxWidth = 1280;

  // Minimum tap target for accessibility
  static const double minTapTarget = 48;

  // Common padding presets
  static const EdgeInsets pagePadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets compactCardPadding = EdgeInsets.all(md);
  static const EdgeInsets listTilePadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  static const EdgeInsets sectionSpacing = EdgeInsets.only(bottom: xxl);
}