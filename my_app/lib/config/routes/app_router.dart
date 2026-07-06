import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/widgets.dart';
import '../../features/about/presentation/pages/about_page.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';
import '../../features/authentication/presentation/pages/authentication_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/scanner/domain/entities/scan_report_entity.dart';
import '../../features/scanner/presentation/pages/scan_result_page.dart';
import '../../features/scanner/presentation/pages/scanner_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../shared/presentation/pages/app_shell_page.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splashPath,
    routes: [
      GoRoute(
        path: RouteNames.splashPath,
        name: RouteNames.splash,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: SplashPage()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShellPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.dashboardPath,
                name: RouteNames.dashboard,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: DashboardPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.scannerPath,
                name: RouteNames.scanner,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: ScannerPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.historyPath,
                name: RouteNames.history,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: HistoryPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.analyticsPath,
                name: RouteNames.analytics,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: AnalyticsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.settingsPath,
                name: RouteNames.settings,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: SettingsPage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.scanResultPath,
        name: RouteNames.scanResult,
        builder: (context, state) {
          final report = state.extra as ScanReportEntity?;
          if (report == null) {
            return const _RouteErrorPage();
          }

          return ScanResultPage(report: report);
        },
      ),
      GoRoute(
        path: RouteNames.aboutPath,
        name: RouteNames.about,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: RouteNames.authenticationPath,
        name: RouteNames.authentication,
        builder: (context, state) => const AuthenticationPage(),
      ),
    ],
    errorBuilder: (context, state) => _RouteErrorPage(error: state.error),
  );
});

/// Centralized navigation helpers used by the application.
abstract final class AppRouter {
  static void goToPath(BuildContext context, String path) => context.go(path);

  static void goToDashboard(BuildContext context) =>
      context.go(RouteNames.dashboardPath);

  static void goToScanner(BuildContext context) =>
      context.go(RouteNames.scannerPath);

  static void goToHistory(BuildContext context) =>
      context.go(RouteNames.historyPath);

  static void goToAnalytics(BuildContext context) =>
      context.go(RouteNames.analyticsPath);

  static Future<void> openScanResult(
    BuildContext context,
    ScanReportEntity report,
  ) {
    return context.push(RouteNames.scanResultPath, extra: report);
  }

  static void openAbout(BuildContext context) =>
      context.push(RouteNames.aboutPath);

  static void openAuthentication(BuildContext context) =>
      context.push(RouteNames.authenticationPath);
}

class _RouteErrorPage extends StatelessWidget {
  const _RouteErrorPage({this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveContainer(
        child: Center(
          child: ErrorCard(
            title: 'Navigation Error',
            message:
                error?.toString() ?? 'The requested route could not be loaded.',
            actionLabel: 'Return to Dashboard',
            onAction: () => AppRouter.goToDashboard(context),
          ),
        ),
      ),
    );
  }
}
