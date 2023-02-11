import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';

class SecondsBuilder extends StatefulWidget {
  const SecondsBuilder({
    Key? key,
    required this.timeEntry,
    this.textStyle,
    this.textAlign = TextAlign.end,
  }) : super(key: key);

  final TimeEntryEntity timeEntry;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  @override
  State<SecondsBuilder> createState() => _SecondsBuilderState();
}

class _SecondsBuilderState extends State<SecondsBuilder> {
  final Stream<int> _secondsStream = Stream<int>.periodic(
    const Duration(seconds: 1),
    (int count) => count,
  );

  late StreamSubscription _subcription;

  late int _seconds;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    int initialDifference = now.difference(widget.timeEntry.startTime).inSeconds;
    _seconds = initialDifference;

    _subcription = _secondsStream.listen((event) {
      setState(() => _seconds = initialDifference + event);
    });
  }

  @override
  void dispose() {
    _subcription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        Utils.toTimerFormat(_seconds),
        textAlign: widget.textAlign,
        style: widget.textStyle ??
            Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 26,
                ),
      ),
    );
  }
}
