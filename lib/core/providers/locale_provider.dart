import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _localePrefsKey = 'selected_locale';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedLocale = prefs.getString(_localePrefsKey);
    return savedLocale != null ? Locale(savedLocale) : const Locale('en');
  }

  void setLocale(Locale newLocale) {
    state = newLocale;
    ref
        .read(sharedPreferencesProvider)
        .setString(_localePrefsKey, newLocale.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
