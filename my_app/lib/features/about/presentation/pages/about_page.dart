import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';

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
            children: const [
              SectionHeader(
                title: AppStrings.appTitle,
                subtitle:
                    'A production-grade Flutter client for malware classification and detection built for thesis demonstration.',
              ),
              SizedBox(height: AppSizes.xl),
              CyberCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Model', style: AppTextStyles.subheading),
                    SizedBox(height: AppSizes.xs),
                    Text(
                      'The application is prepared to consume a CNN + Bi-LSTM prediction service with multipart uploads and structured probability outputs.',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.md),
              CyberCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Architecture', style: AppTextStyles.subheading),
                    SizedBox(height: AppSizes.xs),
                    Text(
                      'Clean Architecture, feature-first organization, MVVM, Riverpod state management, centralized routing, and repository-driven integration boundaries.',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.md),
              CyberCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Defense Readiness', style: AppTextStyles.subheading),
                    SizedBox(height: AppSizes.xs),
                    Text(
                      'This foundation emphasizes maintainability, clear UX states, responsive layout behavior, and a backend-agnostic prediction workflow for your final thesis demonstration.',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
