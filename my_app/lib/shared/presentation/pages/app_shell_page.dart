import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/widgets.dart';

/// Main shell that hosts primary feature branches and bottom navigation.
class AppShellPage extends StatelessWidget {
  /// Creates the main application shell.
  const AppShellPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CyberAppBar(
        title: _titles[navigationShell.currentIndex],
        subtitle: _subtitles[navigationShell.currentIndex],
        actions: [
          IconButton(
            tooltip: AppStrings.aboutTitle,
            onPressed: () => AppRouter.openAbout(context),
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            tooltip: AppStrings.authenticationTitle,
            onPressed: () => AppRouter.openAuthentication(context),
            icon: const Icon(Icons.admin_panel_settings_outlined),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationItem(
            label: 'Dashboard',
            icon: Icons.space_dashboard_outlined,
            selectedIcon: Icons.space_dashboard,
          ),
          BottomNavigationItem(
            label: 'Scanner',
            icon: Icons.radar_outlined,
            selectedIcon: Icons.radar,
          ),
          BottomNavigationItem(
            label: 'History',
            icon: Icons.history_outlined,
            selectedIcon: Icons.history,
          ),
          BottomNavigationItem(
            label: 'Analytics',
            icon: Icons.analytics_outlined,
            selectedIcon: Icons.analytics,
          ),
          BottomNavigationItem(
            label: 'Settings',
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
          ),
        ],
      ),
    );
  }
}

const _titles = <String>[
  AppStrings.dashboardTitle,
  AppStrings.scannerTitle,
  AppStrings.historyTitle,
  AppStrings.analyticsTitle,
  AppStrings.settingsTitle,
];

const _subtitles = <String>[
  'Real-time security posture and scan activity.',
  'Upload workspace for file and image analysis.',
  'Persisted scan records and exports.',
  'Detection ratios and operational insights.',
  'Workspace controls and project access.',
];
