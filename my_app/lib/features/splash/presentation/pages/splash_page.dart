import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../providers/splash_controller.dart';

/// Startup screen shown while the application prepares its initial state.
class SplashPage extends ConsumerWidget {
  /// Creates the splash page.
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<String>>(splashControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (path) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              AppRouter.goToPath(context, path);
            }
          });
        },
        error: (error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              CustomSnackbar.showError(
                context,
                'Unable to initialize the secure workspace.',
              );
            }
          });
        },
      );
    });

    final startupState = ref.watch(splashControllerProvider);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: ResponsiveContainer(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: startupState.when(
                      data: (_) => const _SplashContent(),
                      loading: () => const _SplashContent(),
                      error: (error, stackTrace) => ErrorCard(
                        title: 'Startup validation failed',
                        message: error.toString(),
                        actionLabel: 'Retry',
                        onAction: () =>
                            ref.invalidate(splashControllerProvider),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.26),
            ),
          ),
          child: const Icon(
            Icons.security_rounded,
            size: 42,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.xl),
        Text(AppStrings.appTitle, style: AppTextStyles.display),
        const SizedBox(height: AppSizes.sm),
        Text(AppStrings.splashHeadline, style: AppTextStyles.subheading),
        const SizedBox(height: AppSizes.xs),
        Text(AppStrings.splashDescription, style: AppTextStyles.bodySecondary),
        const SizedBox(height: AppSizes.xxl),
        const CyberCard(
          child: Column(
            children: [
              _SplashChecklistItem(
                label: 'Loading application theme and secure workspace',
              ),
              SizedBox(height: AppSizes.md),
              _SplashChecklistItem(
                label: 'Initializing route guards and shell navigation',
              ),
              SizedBox(height: AppSizes.md),
              _SplashChecklistItem(
                label:
                    'Preparing AI integration boundaries for prediction APIs',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.xl),
        const LinearProgressIndicator(minHeight: 6),
      ],
    );
  }
}

class _SplashChecklistItem extends StatelessWidget {
  const _SplashChecklistItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2.2),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(child: Text(label, style: AppTextStyles.body)),
      ],
    );
  }
}
