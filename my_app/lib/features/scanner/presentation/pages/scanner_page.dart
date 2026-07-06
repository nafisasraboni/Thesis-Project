import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/scan_asset_entity.dart';
import '../providers/scanner_controller.dart';
import '../providers/scanner_state.dart';
import '../widgets/scan_stage_timeline.dart';
import '../widgets/scanner_selection_summary.dart';

/// Scanner workspace for file and image based prediction requests.
class ScannerPage extends ConsumerWidget {
  /// Creates the scanner page.
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ScannerState>(scannerControllerProvider, (previous, next) {
      final notifier = ref.read(scannerControllerProvider.notifier);

      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            CustomDialog.showAppDialog<void>(
              context: context,
              title: next.errorMessage!,
              message: _errorMessage(next.errorMessage!),
              icon: const Icon(Icons.error_outline, color: AppColors.danger),
            );
            notifier.dismissError();
          }
        });
      }

      if (next.latestReport != null &&
          next.latestReport != previous?.latestReport) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!context.mounted) {
            return;
          }

          await AppRouter.openScanResult(context, next.latestReport!);
          notifier.consumeLatestReport();
        });
      }
    });

    final state = ref.watch(scannerControllerProvider);
    final controller = ref.read(scannerControllerProvider.notifier);

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Upload Sources',
              subtitle:
                  'Select a binary file or image sample. The UI is already bound to a repository-driven prediction workflow.',
              trailing: PrimaryButton(
                label: 'Scan Now',
                icon: Icons.play_arrow_rounded,
                isLoading: state.isScanning,
                onPressed: state.hasSelection && !state.isScanning
                    ? controller.runScan
                    : null,
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth =
                    constraints.maxWidth >= AppSizes.tabletBreakpoint
                    ? (constraints.maxWidth - AppSizes.md) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: AppSizes.md,
                  runSpacing: AppSizes.md,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: UploadCard(
                        title: 'Upload File',
                        description:
                            'Supported: EXE, DLL, APK, PDF, DOCX, ZIP, RAR, BIN',
                        icon: Icons.upload_file_outlined,
                        supportedFormats: const [
                          'EXE',
                          'DLL',
                          'APK',
                          'PDF',
                          'DOCX',
                          'ZIP',
                          'RAR',
                          'BIN',
                        ],
                        onTap: state.isScanning ? null : controller.pickFile,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: UploadCard(
                        title: 'Upload Image',
                        description: 'Supported: JPG, JPEG, PNG, BMP, WEBP',
                        icon: Icons.add_photo_alternate_outlined,
                        supportedFormats: const [
                          'JPG',
                          'JPEG',
                          'PNG',
                          'BMP',
                          'WEBP',
                        ],
                        onTap: state.isScanning ? null : controller.pickImage,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSizes.xl),
            if (state.selectedAsset != null) ...[
              const SectionHeader(
                title: 'Selected Asset',
                subtitle:
                    'File metadata is prepared for hashing, preview, and multipart submission.',
              ),
              const SizedBox(height: AppSizes.md),
              _SelectedAssetPanel(
                asset: state.selectedAsset!,
                onClear: state.isScanning ? null : controller.clearSelection,
              ),
              const SizedBox(height: AppSizes.xl),
            ],
            const SectionHeader(
              title: 'Detection Pipeline',
              subtitle:
                  'Each scan progresses through the same staged workflow expected by the CNN + Bi-LSTM backend.',
            ),
            const SizedBox(height: AppSizes.md),
            ScanStageTimeline(
              stages: scannerStages,
              currentStageIndex: state.currentStageIndex,
            ),
            const SizedBox(height: AppSizes.xl),
            CyberCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: const Icon(
                      Icons.integration_instructions_outlined,
                      color: AppColors.info,
                    ),
                  ),
                  const SizedBox(width: AppSizes.md),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'API-ready prediction boundary',
                          style: AppTextStyles.subheading,
                        ),
                        SizedBox(height: AppSizes.xs),
                        Text(
                          'The scanner controller uses a use case, repository, remote data source, and service stack. Swapping the mock inference service for your trained backend will not require UI changes.',
                          style: AppTextStyles.bodySecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _errorMessage(String errorTitle) {
    switch (errorTitle) {
      case 'No Internet':
        return 'The device could not reach the prediction service. Check connectivity and try again.';
      case 'Timeout':
        return 'The prediction request exceeded the expected processing window.';
      case 'Server Error':
        return 'The prediction endpoint returned an invalid response.';
      case 'Permission Denied':
        return 'Access to the prediction service was denied.';
      case 'Unsupported File':
        return 'Please choose a supported file or image format before scanning.';
      case 'Large File':
        return 'The selected asset exceeds the current upload limit of 25 MB.';
      case 'Prediction Failed':
        return 'The prediction service could not generate a result for this asset.';
      default:
        return 'An unexpected error interrupted the scanning workflow.';
    }
  }
}

class _SelectedAssetPanel extends StatelessWidget {
  const _SelectedAssetPanel({required this.asset, required this.onClear});

  final ScanAssetEntity asset;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final panelWidth = constraints.maxWidth >= AppSizes.tabletBreakpoint
            ? (constraints.maxWidth - AppSizes.md) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: AppSizes.md,
          runSpacing: AppSizes.md,
          children: [
            SizedBox(
              width: panelWidth,
              child: ScannerSelectionSummary(asset: asset),
            ),
            SizedBox(
              width: panelWidth,
              child: asset.isImage
                  ? ImagePreviewCard(
                      image: MemoryImage(asset.bytes),
                      fileName: asset.fileName,
                      onRemove: onClear,
                    )
                  : CyberCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ready for Scan',
                            style: AppTextStyles.subheading,
                          ),
                          const SizedBox(height: AppSizes.xs),
                          const Text(
                            'The selected file has been hashed and validated. Start the scan to send it through the prediction use case.',
                            style: AppTextStyles.bodySecondary,
                          ),
                          const SizedBox(height: AppSizes.xl),
                          SecondaryButton(
                            label: 'Clear Selection',
                            icon: Icons.delete_outline,
                            isExpanded: true,
                            onPressed: onClear,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
