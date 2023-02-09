import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/extensions/extensions.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:intl/intl.dart';

class Utils {
  static const animationDuration = Duration(milliseconds: 200);
  static const delayDuration = Duration(milliseconds: 500);

  static void loadMoreListener({
    required ScrollController controller,
    required void Function() onLoading,
  }) {
    final nextPageTrigger = controller.position.maxScrollExtent * 0.9;
    if (controller.position.pixels < nextPageTrigger) {
      return onLoading();
    }
  }

  static String toDateString(DateTime? date, {String format = 'yyyy-MM-dd'}) {
    if (date == null) return '';
    final formatter = DateFormat(format);
    return formatter.format(date);
  }

  static String? formatDate(DateTime? date, {String format = 'dd.MM.yyyy'}) {
    if (date == null) return null;
    return DateFormat(format).format(date);
  }

  static DateTime? parseDate(dynamic date, {String format = 'yyyy-MM-ddTHH:mm:ss'}) {
    if (date == null || date == '') return null;

    try {
      return DateFormat(format).parse('$date');
    } catch (e) {
      debugPrint('Unable to parse date ($date): $e');
    }
    return null;
  }

  static String toTimerFormat(int seconds) {
    Duration duration = Duration(seconds: seconds);
    return duration.toHoursMinutesSeconds();
  }

  static String toDayPrefix(BuildContext context, DateTime date) {
    if (date.isToday) {
      return L10n.of(context).today;
    }
    if (date.isYesterday) {
      return L10n.of(context).yesterday;
    }
    if (date.isTomorrow) {
      return L10n.of(context).tomorrow;
    }
    return formatDate(date) ?? '';
  }

  static ThemeMode parseThemeMode(String? value) {
    switch (value?.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
