import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';

enum PickerMode { date, time, datetime }

extension XPickerMode on PickerMode {
  CupertinoDatePickerMode get cupertinoMode {
    switch (this) {
      case PickerMode.date:
        return CupertinoDatePickerMode.date;
      case PickerMode.time:
        return CupertinoDatePickerMode.time;
      case PickerMode.datetime:
        return CupertinoDatePickerMode.dateAndTime;
    }
  }
}

class DatePickerWidget {
  final BuildContext context;
  final void Function(DateTime)? onDatePicked;
  final DateTime? initialDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final PickerMode pickerMode;

  const DatePickerWidget({
    required this.context,
    this.onDatePicked,
    this.initialDate,
    this.minDate,
    this.maxDate,
    this.pickerMode = PickerMode.date,
  });

  Future<DateTime?> show() async {
    DateTime? value;
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
                  mode: pickerMode.cupertinoMode,
                  maximumDate: maxDate,
                  minimumDate: minDate,
                  maximumYear: DateTime.now().year + 100,
                  minimumYear: DateTime.now().year - 100,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDate) {
                    if (onDatePicked != null) onDatePicked!(newDate);
                    setState(() => value = newDate);
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: AppIconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close_rounded),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return value;

    // value = await showDatePicker(
    //   context: context,
    //   initialDate: initialDate ?? DateTime.now(),
    //   firstDate: minDate ?? DateTime.now().subtract(const Duration(days: 365 * 100)),
    //   lastDate: maxDate ?? DateTime.now().add(const Duration(days: 365 * 100)),
    // );
    // return value;
  }
}
