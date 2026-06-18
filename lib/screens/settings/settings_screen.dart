import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/settings_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/borrow_lend_provider.dart';
import '../../providers/reminder_provider.dart';
import '../../core/database/database_helper.dart';
import '../../core/notifications/notification_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final List<Map<String, String>> _allLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'हिंदी (Hindi)'},
    {'code': 'es', 'name': 'Español (Spanish)'},
    {'code': 'fr', 'name': 'Français (French)'},
    {'code': 'de', 'name': 'Deutsch (German)'},
    {'code': 'ja', 'name': '日本語 (Japanese)'},
    {'code': 'zh', 'name': '中文 (Chinese)'},
    {'code': 'pt', 'name': 'Português (Portuguese)'},
    {'code': 'ru', 'name': 'Русский (Russian)'},
    {'code': 'ko', 'name': '한국어 (Korean)'},
    {'code': 'ar', 'name': 'العربية (Arabic)'},
    {'code': 'it', 'name': 'Italiano (Italian)'},
  ];

  final List<Map<String, String>> _allCurrencies = [
    {'symbol': '₹', 'name': 'INR - Indian Rupee'},
    {'symbol': '\$', 'name': 'USD - US Dollar'},
    {'symbol': '€', 'name': 'EUR - Euro'},
    {'symbol': '£', 'name': 'GBP - British Pound'},
    {'symbol': '¥', 'name': 'JPY - Japanese Yen'},
    {'symbol': 'CN¥', 'name': 'CNY - Chinese Yuan'},
    {'symbol': 'A\$', 'name': 'AUD - Australian Dollar'},
    {'symbol': 'C\$', 'name': 'CAD - Canadian Dollar'},
    {'symbol': 'CHF', 'name': 'CHF - Swiss Franc'},
    {'symbol': 'kr', 'name': 'SEK/NOK/DKK - Krone'},
    {'symbol': 'R\$', 'name': 'BRL - Brazilian Real'},
    {'symbol': '₽', 'name': 'RUB - Russian Ruble'},
    {'symbol': '₩', 'name': 'KRW - South Korean Won'},
    {'symbol': 'Mex\$', 'name': 'MXN - Mexican Peso'},
    {'symbol': 'S\$', 'name': 'SGD - Singapore Dollar'},
    {'symbol': 'NZ\$', 'name': 'NZD - New Zealand Dollar'},
    {'symbol': 'HK\$', 'name': 'HKD - Hong Kong Dollar'},
    {'symbol': '₺', 'name': 'TRY - Turkish Lira'},
    {'symbol': 'R', 'name': 'ZAR - South African Rand'},
    {'symbol': 'Rp', 'name': 'IDR - Indonesian Rupiah'},
    {'symbol': 'RM', 'name': 'MYR - Malaysian Ringgit'},
    {'symbol': '₱', 'name': 'PHP - Philippine Peso'},
    {'symbol': '฿', 'name': 'THB - Thai Baht'},
    {'symbol': '₫', 'name': 'VND - Vietnamese Dong'},
    {'symbol': '₪', 'name': 'ILS - Israeli New Shekel'},
    {'symbol': 'د.إ', 'name': 'AED - UAE Dirham'},
    {'symbol': 'SAR', 'name': 'SAR - Saudi Riyal'},
    {'symbol': 'E£', 'name': 'EGP - Egyptian Pound'},
    {'symbol': '₦', 'name': 'NGN - Nigerian Naira'},
    {'symbol': 'KSh', 'name': 'KES - Kenyan Shilling'},
  ];

  String _getLanguageName(String code) {
    final match = _allLanguages.firstWhere(
      (l) => l['code'] == code,
      orElse: () => {'name': code},
    );
    return match['name']!;
  }

  String _getCurrencyName(String symbol) {
    final match = _allCurrencies.firstWhere(
      (c) => c['symbol'] == symbol,
      orElse: () => {'name': symbol},
    );
    return match['name']!;
  }

  void _confirmDelete() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteAccount),
        content: Text(l10n.deleteAccountConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authProvider.notifier).deleteAccount();
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  void _confirmResetData() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.resetData),
        content: Text(l10n.resetDataConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(ctx);

              // 1. Wipe database tables
              await DatabaseHelper().clearAllData();

              // 2. Clear scheduled local notifications
              await NotificationService().cancelAll();

              // 3. Invalidate providers to refresh UI state
              ref.invalidate(transactionProvider);
              ref.invalidate(borrowLendProvider);
              ref.invalidate(reminderProvider);
              ref.invalidate(dashboardProvider);

              // 4. Toast feedback
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(l10n.resetSuccessful),
                  backgroundColor: Colors.green,
                ));
              }
            },
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
  }

  void _openLanguageSelectionSheet(String currentLocale) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => LanguageSelectionSheet(
        allLanguages: _allLanguages,
        selectedLocaleCode: currentLocale,
        onSelected: (code) {
          ref.read(settingsProvider.notifier).setLocale(code);
        },
      ),
    );
  }

  void _openCurrencySelectionSheet(String currentCurrency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => CurrencySelectionSheet(
        allCurrencies: _allCurrencies,
        selectedCurrencySymbol: currentCurrency,
        onSelected: (symbol) {
          ref.read(settingsProvider.notifier).setCurrencySymbol(symbol);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsState = ref.watch(settingsProvider);
    final authState = ref.watch(authStateProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
          backgroundColor: Colors.red,
        ));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileCard(authState.value),
          const SizedBox(height: 24),
          _buildGeneralSection(settingsState),
          const SizedBox(height: 24),
          _buildDataSection(),
          const SizedBox(height: 24),
          _buildAccountSection(),
        ],
      ),
    );
  }

  Widget _buildProfileCard(User? user) {
    final email = user?.email ?? AppLocalizations.of(context)!.guest;
    final initial = email.isNotEmpty ? email[0].toUpperCase() : 'G';
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
              child: Text(
                initial,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.profile,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSection(SettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              l10n.languageCountry,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
            title: Text(l10n.languageCountry),
            subtitle: Text(_getLanguageName(state.locale.languageCode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openLanguageSelectionSheet(state.locale.languageCode),
          ),
          const Divider(height: 1, indent: 56),
          ListTile(
            leading: Icon(Icons.currency_exchange, color: Theme.of(context).colorScheme.primary),
            title: Text(l10n.currencyCountry),
            subtitle: Text(_getCurrencyName(state.currencySymbol)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openCurrencySelectionSheet(state.currencySymbol),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSection() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              l10n.resetData,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary),
            title: Text(l10n.resetData),
            subtitle: Text(l10n.resetDataConfirm),
            onTap: _confirmResetData,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              l10n.account,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black87),
            title: Text(l10n.logout),
            onTap: () {
              ref.read(authProvider.notifier).signOut();
            },
          ),
          const Divider(height: 1, indent: 56),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(l10n.deleteAccount, style: const TextStyle(color: Colors.red)),
            onTap: _confirmDelete,
          ),
        ],
      ),
    );
  }
}

class LanguageSelectionSheet extends StatefulWidget {
  final List<Map<String, String>> allLanguages;
  final String selectedLocaleCode;
  final ValueChanged<String> onSelected;

  const LanguageSelectionSheet({
    super.key,
    required this.allLanguages,
    required this.selectedLocaleCode,
    required this.onSelected,
  });

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filtered = widget.allLanguages
        .where((l) => l['name']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.selectLanguage,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n.searchLanguages,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: filtered.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(child: Text(l10n.noLanguagesFound)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final lang = filtered[index];
                      final isSelected = lang['code'] == widget.selectedLocaleCode;
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text(
                          lang['name']!,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                            : null,
                        tileColor: isSelected
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
                            : null,
                        onTap: () {
                          widget.onSelected(lang['code']!);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CurrencySelectionSheet extends StatefulWidget {
  final List<Map<String, String>> allCurrencies;
  final String selectedCurrencySymbol;
  final ValueChanged<String> onSelected;

  const CurrencySelectionSheet({
    super.key,
    required this.allCurrencies,
    required this.selectedCurrencySymbol,
    required this.onSelected,
  });

  @override
  State<CurrencySelectionSheet> createState() => _CurrencySelectionSheetState();
}

class _CurrencySelectionSheetState extends State<CurrencySelectionSheet> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filtered = widget.allCurrencies
        .where((c) =>
            c['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            c['symbol']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.selectCurrency,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n.searchCurrencies,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: filtered.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(child: Text(l10n.noCurrenciesFound)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final curr = filtered[index];
                      final isSelected = curr['symbol'] == widget.selectedCurrencySymbol;
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.surfaceContainerHighest,
                          foregroundColor: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                          child: Text(curr['symbol']!),
                        ),
                        title: Text(
                          curr['name']!,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                            : null,
                        tileColor: isSelected
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
                            : null,
                        onTap: () {
                          widget.onSelected(curr['symbol']!);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
