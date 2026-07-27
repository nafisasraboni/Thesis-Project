import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/supabase_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';

/// Authentication gateway with real Supabase email/password auth.
class AuthenticationPage extends ConsumerStatefulWidget {
  const AuthenticationPage({super.key});

  @override
  ConsumerState<AuthenticationPage> createState() =>
      _AuthenticationPageState();
}

class _AuthenticationPageState extends ConsumerState<AuthenticationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = SupabaseService().currentUser;

    return Scaffold(
      appBar: const AppAppBar(
        title: 'Access Portal',
        subtitle: 'Sign in with your Supabase account',
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
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusSm),
                        ),
                        child: const Icon(
                          Icons.admin_panel_settings_outlined,
                          color: AppColors.primary,
                          size: AppSizes.iconMd,
                        ),
                      ),
                      const SizedBox(width: AppSizes.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isSignUp
                                  ? 'Create Account'
                                  : 'Secure Sign-In',
                              style: AppTextStyles.heading,
                            ),
                            if (user != null)
                              Text(
                                'Signed in as ${user.email}',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    _isSignUp
                        ? 'Create a new Supabase account'
                        : 'Sign in with your Supabase email and password',
                    style: AppTextStyles.bodySecondary,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  AppTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: AppSizes.md),
                  AppTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    obscureText: true,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  PrimaryButton(
                    label: _isSignUp ? 'Sign Up' : 'Sign In',
                    icon: Icons.login_outlined,
                    isExpanded: true,
                    isLoading: _isLoading,
                    onPressed: _isLoading ? null : _handleAuth,
                  ),
                  const SizedBox(height: AppSizes.md),
                  if (user != null) ...[
                    SecondaryButton(
                      label: 'Sign Out',
                      icon: Icons.logout_outlined,
                      isExpanded: true,
                      onPressed: _isLoading ? null : _handleSignOut,
                    ),
                    const SizedBox(height: AppSizes.md),
                  ],
                  SecondaryButton(
                    label: _isSignUp
                        ? 'Already have an account? Sign In'
                        : 'Don\'t have an account? Sign Up',
                    icon: Icons.swap_horiz_outlined,
                    isExpanded: true,
                    onPressed: _toggleMode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleMode() {
    setState(() => _isSignUp = !_isSignUp);
  }

  Future<void> _handleAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.showError(context, 'Please enter email and password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final service = SupabaseService();

      if (_isSignUp) {
        await service.signUp(email: email, password: password);
        if (mounted) {
          CustomSnackbar.showSuccess(
            context,
            'Account created! Check your email to confirm.',
          );
        }
      } else {
        await service.signInWithPassword(email: email, password: password);
        if (mounted) {
          CustomSnackbar.showSuccess(context, 'Signed in successfully');
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(context, 'An unexpected error occurred');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignOut() async {
    setState(() => _isLoading = true);
    try {
      await SupabaseService().signOut();
      if (mounted) {
        CustomSnackbar.showSuccess(context, 'Signed out');
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(context, 'Sign out failed');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}