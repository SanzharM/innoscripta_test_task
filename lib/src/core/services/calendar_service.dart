import 'package:add_2_calendar/add_2_calendar.dart';

class CalendarService {
  static Future<bool> addEvent({
    required String title,
    String? description,
    String? location,
    required DateTime startDate,
    DateTime? endDate,
  }) async {
    final event = Event(
      title: title,
      description: description,
      location: location,
      startDate: startDate,
      endDate: endDate ?? DateTime(startDate.year, startDate.month, startDate.day + 1),
      iosParams: const IOSParams(),
      androidParams: const AndroidParams(),
    );
    return await Add2Calendar.addEvent2Cal(event);
  }
}
