import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/widgets/widgets.dart';
import '../widgets/about_info_card.dart';

/// About page describing the thesis product and technical direction.
class AboutPage extends StatelessWidget {
  /// Creates the about page.
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CyberAppBar(
        title: 'About Project',
        subtitle: 'Thesis scope, architecture, and AI integration plan.',
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: AppStrings.appTitle,
                subtitle:
                    'A production-grade Flutter client for malware classification and detection built for thesis defense readiness.',
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
                        child: const AboutInfoCard(
                          title: 'Thesis Objective',
                          icon: Icons.school_outlined,
                          description:
                              'This system analyzes uploaded files and images, sends them through a malware classification pipeline, and presents a professional result workflow for safe, suspicious, and malware detections.',
                          footer:
                              'Designed to demonstrate commercial-grade architecture instead of a student CRUD pattern.',
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const AboutInfoCard(
                          title: 'AI Model Integration',
                          icon: Icons.model_training_outlined,
                          description:
                              'The scanner is already separated behind use cases, repositories, remote data sources, and services. Your trained CNN + Bi-LSTM backend can replace the mock service without changing the UI.',
                          footer:
                              'HTTP contract: POST /api/predict using multipart/form-data.',
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSizes.md),
              const AboutInfoCard(
                title: 'Architecture',
                icon: Icons.account_tree_outlined,
                description:
                    'The app uses Clean Architecture, feature-first organization, MVVM-style presentation flow, Riverpod state management, centralized GoRouter navigation, repository pattern, and Drift-backed local persistence.',
                footer:
                    'Business logic stays outside widgets so the product remains scalable and maintainable.',
              ),
              const SizedBox(height: AppSizes.md),
              const AboutInfoCard(
                title: 'Defense Readiness',
                icon: Icons.verified_outlined,
                description:
                    'The product includes a dashboard, scanner, history, analytics, configurable runtime settings, responsive layouts, structured result states, and a backend-agnostic prediction boundary suitable for live demonstrations.',
                footer:
                    'The current implementation is ready for a dummy backend now and the trained model later.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
