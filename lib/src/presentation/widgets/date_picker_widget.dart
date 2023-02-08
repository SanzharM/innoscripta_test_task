import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerWidget {
  final BuildContext context;
  final void Function(DateTime)? onDatePicked;
  final DateTime? initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;

  const DatePickerWidget({
    required this.context,
    this.onDatePicked,
    this.initialDate,
    this.minDate,
    this.maxDate,
  });

  Future<DateTime?> show() async {
    DateTime? value;
    if (Platform.isIOS || Platform.isMacOS) {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: Stack(
                children: [
                  CupertinoDatePicker(
                    initialDateTime: initialDate,
                    mode: CupertinoDatePickerMode.date,
                    maximumDate: maxDate,
                    minimumDate: minDate,
                    maximumYear: DateTime.now().year + 100,
                    minimumYear: DateTime.now().year - 100,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() => value = newDate);
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
      return value;
    }

    value = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: minDate ?? DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: maxDate ?? DateTime.now().add(const Duration(days: 365 * 100)),
    );
    return value;
  }
}
