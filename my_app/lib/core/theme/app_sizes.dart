import 'package:flutter/widgets.dart';

/// Spacing, radius, sizing, and breakpoint tokens.
abstract final class AppSizes {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;

  static const double radiusSm = 10;
  static const double radiusMd = 16;
  static const double radiusLg = 22;

  static const double iconSm = 18;
  static const double iconMd = 24;
  static const double iconLg = 32;

  static const double desktopBreakpoint = 1200;
  static const double tabletBreakpoint = 768;
  static const double mobileBreakpoint = 480;
  static const double contentMaxWidth = 1280;

  static const EdgeInsets pagePadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets compactCardPadding = EdgeInsets.all(md);
}
