import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:innoscripta_test_task/src/domain/entities/custom_theme/custom_theme.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

class LocalStorage {
  LocalStorage();

  final _storage = sl<FlutterSecureStorage>();

  FlutterSecureStorage get storage => _storage;

  static const _languageKey = 'InnoscriptaLanguageKey';
  static const _themeKey = 'InnoscriptaThemeKey';

  Future<void> clearStorage() async {
    await _storage.delete(key: _languageKey);
    await _storage.delete(key: _themeKey);
    return await _storage.deleteAll();
  }

  Future<void> setLanguage(Locale locale) {
    return _storage.write(key: _languageKey, value: locale.languageCode);
  }

  Future<String?> getLanguage() {
    return _storage.read(key: _languageKey);
  }

  Future<void> setTheme(CustomTheme theme) {
    return _storage.write(key: _themeKey, value: theme.toJson());
  }

  Future<CustomTheme> getTheme() async {
    final rawData = await _storage.read(key: _themeKey);
    if (rawData?.isEmpty ?? true) {
      return CustomTheme.defaultTheme;
    }
    return CustomTheme.fromJson(rawData!);
  }
}
