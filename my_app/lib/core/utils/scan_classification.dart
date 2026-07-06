import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// High-level malware prediction categories exposed to the UI.
enum ScanClassification { safe, suspicious, malwareDetected }

extension ScanClassificationX on ScanClassification {
  String get label {
    switch (this) {
      case ScanClassification.safe:
        return 'Safe';
      case ScanClassification.suspicious:
        return 'Suspicious';
      case ScanClassification.malwareDetected:
        return 'Malware Detected';
    }
  }

  Color get color {
    switch (this) {
      case ScanClassification.safe:
        return AppColors.success;
      case ScanClassification.suspicious:
        return AppColors.warning;
      case ScanClassification.malwareDetected:
        return AppColors.danger;
    }
  }

  IconData get icon {
    switch (this) {
      case ScanClassification.safe:
        return Icons.verified_user_outlined;
      case ScanClassification.suspicious:
        return Icons.warning_amber_rounded;
      case ScanClassification.malwareDetected:
        return Icons.report_gmailerrorred_rounded;
    }
  }

  String get defaultMessage {
    switch (this) {
      case ScanClassification.safe:
        return 'This file appears to be safe.';
      case ScanClassification.suspicious:
        return 'This file appears suspicious. Please verify before opening or sharing.';
      case ScanClassification.malwareDetected:
        return 'WARNING: This file may contain malware. Do not open, execute, or share it.';
    }
  }
}
