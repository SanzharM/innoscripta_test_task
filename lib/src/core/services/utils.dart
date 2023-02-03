import 'package:flutter/widgets.dart';
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
}
