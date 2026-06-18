import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/router/app_router.dart';
import '../../providers/auth_provider.dart';
import '../../l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isEmailMode = false;
  bool _isSignUp = false;
  bool _isObscured = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submitEmail() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSignUp) {
      await ref.read(authProvider.notifier).signUpWithEmail(_emailCtrl.text.trim(), _passwordCtrl.text.trim());
    } else {
      await ref.read(authProvider.notifier).signInWithEmail(_emailCtrl.text.trim(), _passwordCtrl.text.trim());
    }
  }

  Future<void> _signInWithGoogle() async {
    await ref.read(authProvider.notifier).signInWithGoogle();
  }

  // Placeholder for Apple Sign In
  Future<void> _signInWithApple() async {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.appleSignInComingSoon)));
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AsyncLoading;
    final l10n = AppLocalizations.of(context)!;

    ref.listen(authProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString().replaceAll('Exception: ', '')),
          backgroundColor: Colors.red,
        ));
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Logo + branding
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(14)),
                      child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.appTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                        Text(l10n.welcomeBack, style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (!_isEmailMode) ...[
                  Text(l10n.signIn, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.onSurface, letterSpacing: -0.5)),
                  const SizedBox(height: 4),
                  Text(l10n.continuePreferredAccount, style: const TextStyle(fontSize: 14, color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 32),

                  // Google Button
                  _SocialButton(
                    icon: Icons.g_mobiledata,
                    label: l10n.continueGoogle,
                    onTap: _signInWithGoogle,
                    bgColor: Colors.white,
                    textColor: Colors.black87,
                  ),
                  const SizedBox(height: 16),

                  // Apple Button
                  _SocialButton(
                    icon: Icons.apple,
                    label: l10n.continueApple,
                    onTap: _signInWithApple,
                    bgColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('OR', style: TextStyle(color: AppColors.onSurfaceVariant.withOpacity(0.5))),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => setState(() => _isEmailMode = true),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Text(l10n.continueEmail, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ] else ...[
                  // Email Mode
                  IconButton(
                    onPressed: () => setState(() => _isEmailMode = false),
                    icon: const Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 16),
                  Text(_isSignUp ? l10n.signUp : l10n.signIn, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.onSurface, letterSpacing: -0.5)),
                  const SizedBox(height: 32),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: l10n.email, prefixIcon: const Icon(Icons.email_outlined)),
                          validator: (v) => (v == null || !v.contains('@')) ? l10n.validEmailRequired : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _isObscured,
                          decoration: InputDecoration(
                            labelText: l10n.password,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                              onPressed: () => setState(() => _isObscured = !_isObscured),
                            ),
                          ),
                          validator: (v) => (v == null || v.length < 6) ? l10n.passwordLengthHelp : null,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: _submitEmail,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            ),
                            child: Text(_isSignUp ? l10n.createAccount : l10n.signIn, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => setState(() => _isSignUp = !_isSignUp),
                      child: Text(_isSignUp ? l10n.alreadyHaveAccount : l10n.dontHaveAccount),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;

  const _SocialButton({required this.icon, required this.label, required this.onTap, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 28),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
