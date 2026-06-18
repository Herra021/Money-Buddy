import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/settings_provider.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _langSearch = '';
  String _currSearch = '';

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsState = ref.watch(settingsProvider);

    ref.listen(authProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
          backgroundColor: Colors.red,
        ));
      }
    });

    final filteredLangs = _allLanguages.where((l) => l['name']!.toLowerCase().contains(_langSearch.toLowerCase())).toList();
    final filteredCurrs = _allCurrencies.where((c) => c['name']!.toLowerCase().contains(_currSearch.toLowerCase()) || c['symbol']!.contains(_currSearch)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLanguageSection(filteredLangs, settingsState),
          const SizedBox(height: 24),
          _buildCurrencySection(filteredCurrs, settingsState),
          const SizedBox(height: 24),
          _buildAccountSection(),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(List<Map<String, String>> langs, SettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.languageCountry,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.searchLanguages,
                prefixIcon: const Icon(Icons.search),
                isDense: true,
              ),
              onChanged: (val) => setState(() => _langSearch = val),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          if (langs.isEmpty) Padding(padding: const EdgeInsets.all(16.0), child: Text(l10n.noLanguagesFound)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: langs.length,
            itemBuilder: (context, index) {
              final lang = langs[index];
              return RadioListTile<String>(
                title: Text(lang['name']!),
                value: lang['code']!,
                groupValue: state.locale.languageCode,
                onChanged: (value) {
                  if (value != null) ref.read(settingsProvider.notifier).setLocale(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySection(List<Map<String, String>> currs, SettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.currencyCountry,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.searchCurrencies,
                prefixIcon: const Icon(Icons.search),
                isDense: true,
              ),
              onChanged: (val) => setState(() => _currSearch = val),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          if (currs.isEmpty) Padding(padding: const EdgeInsets.all(16.0), child: Text(l10n.noCurrenciesFound)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currs.length,
            itemBuilder: (context, index) {
              final curr = currs[index];
              return RadioListTile<String>(
                title: Text('${curr['symbol']}  (${curr['name']})'),
                value: curr['symbol']!,
                groupValue: state.currencySymbol,
                onChanged: (value) {
                  if (value != null) ref.read(settingsProvider.notifier).setCurrencySymbol(value);
                },
              );
            },
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
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.account,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black87),
            title: Text(l10n.logout),
            onTap: () {
              ref.read(authProvider.notifier).signOut();
            },
          ),
          const Divider(height: 1),
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
