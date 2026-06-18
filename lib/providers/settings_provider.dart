import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final Locale locale;
  final String currencySymbol;

  const SettingsState({
    required this.locale,
    required this.currencySymbol,
  });

  SettingsState copyWith({
    Locale? locale,
    String? currencySymbol,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
      currencySymbol: currencySymbol ?? this.currencySymbol,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState(locale: Locale('en'), currencySymbol: '₹')) {
    _loadSettings();
  }

  static const _localeKey = 'app_locale';
  static const _currencyKey = 'app_currency';

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey) ?? 'en';
    final currencySymbol = prefs.getString(_currencyKey) ?? '₹';

    state = SettingsState(
      locale: Locale(localeCode),
      currencySymbol: currencySymbol,
    );
  }

  Future<void> setLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
    state = state.copyWith(locale: Locale(languageCode));
  }

  Future<void> setCurrencySymbol(String symbol) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyKey, symbol);
    state = state.copyWith(currencySymbol: symbol);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
