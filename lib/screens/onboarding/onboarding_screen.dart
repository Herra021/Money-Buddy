import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import '../../core/router/app_router.dart';
import '../../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _next() async {
    if (_currentPage < 3) {
      _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_done', true);
      if (mounted) context.go(AppRoutes.login);
    }
  }

  void _skip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = [
      _OnboardingPage(
        icon: Icons.account_balance_wallet_rounded,
        iconColor: AppColors.primaryContainer,
        title: l10n.welcomeTitle,
        subtitle: l10n.welcomeSubtitle,
        tag: l10n.tagGetStarted,
      ),
      _OnboardingPage(
        icon: Icons.bolt_rounded,
        iconColor: const Color(0xFFF4511E),
        title: l10n.fastEntryTitle,
        subtitle: l10n.fastEntrySubtitle,
        tag: l10n.tagFastEntry,
      ),
      _OnboardingPage(
        icon: Icons.mic_rounded,
        iconColor: AppColors.secondary,
        title: l10n.voiceEntryTitle,
        subtitle: l10n.voiceEntrySubtitle,
        tag: l10n.tagVoiceEntry,
      ),
      _OnboardingPage(
        icon: Icons.handshake_rounded,
        iconColor: const Color(0xFF8E24AA),
        title: l10n.borrowLendTitle,
        subtitle: l10n.borrowLendSubtitle,
        tag: l10n.tagBorrowLend,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Progress dots
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (i) {
                  final isActive = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primaryContainer : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  );
                }),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: pages.length,
                itemBuilder: (context, i) => _PageContent(page: pages[i]),
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _next,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == pages.length - 1 ? l10n.getStarted : l10n.next,
                            style: const TextStyle(
                              
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                  if (_currentPage < pages.length - 1) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _skip,
                      child: Text(
                        l10n.skip,
                        style: const TextStyle(
                          
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.outline,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String tag;
  const _OnboardingPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.tag,
  });
}

class _PageContent extends StatelessWidget {
  final _OnboardingPage page;
  const _PageContent({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          // Visual illustration area
          Expanded(
            flex: 5,
            child: Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      page.iconColor.withOpacity(0.15),
                      page.iconColor.withOpacity(0.04),
                    ],
                    radius: 0.8,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: page.iconColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: page.iconColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(page.icon, size: 52, color: page.iconColor),
                  ),
                ),
              ),
            ),
          ),

          // Text content
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: page.iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: page.iconColor.withOpacity(0.2)),
                  ),
                  child: Text(
                    page.tag,
                    style: TextStyle(
                      
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: page.iconColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  page.title,
                  style: const TextStyle(
                    
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                    height: 1.25,
                    letterSpacing: -0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  page.subtitle,
                  style: const TextStyle(
                    
                    fontSize: 15,
                    color: AppColors.onSurfaceVariant,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
