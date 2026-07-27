import 'package:flutter/material.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/utils/scan_classification.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/scan_report_entity.dart';
import '../widgets/probability_distribution_card.dart';

/// Dedicated result screen for a completed malware prediction.
class ScanResultPage extends StatelessWidget {
  const ScanResultPage({required this.report, super.key});

  final ScanReportEntity report;

  @override
  Widget build(BuildContext context) {
    final prediction = report.prediction;
    final asset = report.asset;
    final classification = prediction.classification;

    return Scaffold(
      appBar: const AppAppBar(
        title: 'Prediction Result',
        subtitle: 'Detailed assessment from the detection pipeline',
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: prediction.prediction,
                subtitle:
                    'Threat Level: ${prediction.threatLevel} | ${AppFormatters.formatDateTime(report.scanDate)}',
              ),
              const SizedBox(height: AppSizes.xl),
              ResultCard(
                classification: classification,
                confidence: prediction.confidence,
                processingTime: prediction.processingTime,
              ),
              if (classification != ScanClassification.safe) ...[
                const SizedBox(height: AppSizes.md),
                WarningCard(
                  classification: classification,
                  title: _warningTitle(classification),
                  message: _warningMessage(classification),
                ),
              ],
              const SizedBox(height: AppSizes.xl),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide =
                      constraints.maxWidth >= AppSizes.tabletBreakpoint;
                  final leftWidth = isWide
                      ? (constraints.maxWidth - AppSizes.md) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: AppSizes.md,
                    runSpacing: AppSizes.md,
                    children: [
                      SizedBox(
                        width: leftWidth,
                        child: ProbabilityDistributionCard(
                          probabilities: prediction.probabilities,
                        ),
                      ),
                      SizedBox(
                        width: leftWidth,
                        child: AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Result Metadata',
                                style: AppTextStyles.subheading,
                              ),
                              const SizedBox(height: AppSizes.lg),
                              _DetailRow(
                                label: 'Prediction',
                                value: prediction.prediction,
                              ),
                              _DetailRow(
                                label: 'Confidence',
                                value:
                                    '${prediction.confidence.toStringAsFixed(2)}%',
                              ),
                              _DetailRow(
                                label: 'Processing Time',
                                value: prediction.processingTime,
                              ),
                              _DetailRow(
                                label: 'Threat Level',
                                value: prediction.threatLevel,
                              ),
                              _DetailRow(
                                label: 'Scan Date',
                                value: AppFormatters.formatDateTime(
                                  report.scanDate,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSizes.xl),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('File Details', style: AppTextStyles.subheading),
                    const SizedBox(height: AppSizes.lg),
                    _DetailRow(label: 'File Name', value: asset.fileName),
                    _DetailRow(
                      label: 'Extension',
                      value: asset.extension.toUpperCase(),
                    ),
                    _DetailRow(
                      label: 'Size',
                      value: AppFormatters.formatFileSize(asset.sizeInBytes),
                    ),
                    _DetailRow(label: 'SHA256', value: asset.sha256),
                  ],
                ),
              ),
              if (asset.isImage && asset.bytes.isNotEmpty) ...[
                const SizedBox(height: AppSizes.xl),
                ImagePreviewCard(
                  image: MemoryImage(asset.bytes),
                  fileName: asset.fileName,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _warningTitle(ScanClassification classification) {
    switch (classification) {
      case ScanClassification.safe:
        return 'Safe assessment';
      case ScanClassification.suspicious:
        return 'Suspicious assessment';
      case ScanClassification.malwareDetected:
        return 'Critical malware warning';
    }
  }

  String _warningMessage(ScanClassification classification) {
    switch (classification) {
      case ScanClassification.safe:
        return 'This file appears to be safe.';
      case ScanClassification.suspicious:
        return 'This file appears suspicious. Please verify before opening or sharing.';
      case ScanClassification.malwareDetected:
        return 'WARNING: This file may contain malware. Do NOT open, execute, or share this file. Delete it immediately if untrusted.';
    }
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: AppTextStyles.caption),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: SelectableText(
              value,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}