import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/cyber_card.dart';

/// Donut chart that visualizes safe, suspicious, and malware ratios.
class AnalyticsDistributionChart extends StatelessWidget {
  /// Creates a distribution chart card.
  const AnalyticsDistributionChart({
    required this.safeRatio,
    required this.suspiciousRatio,
    required this.malwareRatio,
    super.key,
  });

  final double safeRatio;
  final double suspiciousRatio;
  final double malwareRatio;

  @override
  Widget build(BuildContext context) {
    final segments = <_DistributionSegment>[
      _DistributionSegment('Safe', safeRatio, AppColors.success),
      _DistributionSegment('Suspicious', suspiciousRatio, AppColors.warning),
      _DistributionSegment('Malware', malwareRatio, AppColors.danger),
    ];

    return CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Classification Mix', style: AppTextStyles.subheading),
          const SizedBox(height: AppSizes.xs),
          const Text(
            'Real-time classification distribution across persisted scan results.',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: AppSizes.lg),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 420;
              final chart = SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size.square(180),
                      painter: _DonutChartPainter(segments),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Threat', style: AppTextStyles.label),
                        Text(
                          '${(malwareRatio * 100).toStringAsFixed(1)}%',
                          style: AppTextStyles.metric,
                        ),
                      ],
                    ),
                  ],
                ),
              );

              final legend = Column(
                children: segments
                    .map(
                      (segment) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.sm),
                        child: _LegendTile(segment: segment),
                      ),
                    )
                    .toList(),
              );

              if (isWide) {
                return Row(
                  children: [
                    chart,
                    const SizedBox(width: AppSizes.xl),
                    Expanded(child: legend),
                  ],
                );
              }

              return Column(
                children: [
                  chart,
                  const SizedBox(height: AppSizes.lg),
                  legend,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LegendTile extends StatelessWidget {
  const _LegendTile({required this.segment});

  final _DistributionSegment segment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: segment.color,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: AppSizes.sm),
        Expanded(child: Text(segment.label, style: AppTextStyles.body)),
        Text(
          '${(segment.value * 100).toStringAsFixed(1)}%',
          style: AppTextStyles.label.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  const _DonutChartPainter(this.segments);

  final List<_DistributionSegment> segments;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 22.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = AppColors.surfaceSoft
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    var startAngle = -math.pi / 2;

    for (final segment in segments) {
      final sweepAngle = math.pi * 2 * segment.value.clamp(0, 1);
      if (sweepAngle <= 0) {
        continue;
      }

      foregroundPaint.color = segment.color;
      canvas.drawArc(
        rect.deflate(strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        foregroundPaint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.segments != segments;
  }
}

class _DistributionSegment {
  const _DistributionSegment(this.label, this.value, this.color);

  final String label;
  final double value;
  final Color color;
}
