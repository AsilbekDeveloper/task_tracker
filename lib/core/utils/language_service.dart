import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker_app/core/di/service_locator.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class LanguageService {
  static const String _key = 'selected_language';

  static void init() {
    final prefs = sl<SharedPreferences>();
    final String? languageTag = prefs.getString(_key);

    if (languageTag != null) {
      final locale = AppLocaleUtils.parse(languageTag);
      LocaleSettings.setLocale(locale);
    } else {
      LocaleSettings.useDeviceLocale();
    }
  }

  static Future<void> changeLanguage(AppLocale locale) async {
    final prefs = sl<SharedPreferences>();
    await prefs.setString(_key, locale.languageTag);
    LocaleSettings.setLocale(locale);
  }
}