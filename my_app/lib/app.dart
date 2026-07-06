import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/routes/app_router.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

/// Root application widget for the malware classification platform.
class MalwareDetectionApp extends ConsumerWidget {
  /// Creates the application root.
  const MalwareDetectionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
