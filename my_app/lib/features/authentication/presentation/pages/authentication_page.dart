import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';

/// Authentication gateway reserved for future secure access workflows.
class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(
        title: 'Access Portal',
        subtitle: 'Administrative access workflow prepared for future integration',
      ),
      body: ResponsiveContainer(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: AppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(40),
                          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                        ),
                        child: const Icon(
                          Icons.admin_panel_settings_outlined,
                          color: AppColors.primary,
                          size: AppSizes.iconMd,
                        ),
                      ),
                      const SizedBox(width: AppSizes.md),
                      const Expanded(
                        child: Text('Secure Sign-In', style: AppTextStyles.heading),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xs),
                  const Text(
                    'This gateway is positioned for identity integration without affecting the core detection UI',
                    style: AppTextStyles.bodySecondary,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  const AppTextField(
                    labelText: 'Username',
                    hintText: 'Enter your administrative username',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  const SizedBox(height: AppSizes.md),
                  const AppTextField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock_outline),
                    obscureText: true,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  PrimaryButton(
                    label: 'Continue',
                    icon: Icons.login_outlined,
                    isExpanded: true,
                    onPressed: () => CustomSnackbar.showInfo(
                      context,
                      AppStrings.unsupportedFeatureMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}