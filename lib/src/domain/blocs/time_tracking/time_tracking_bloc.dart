import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/time_entry/time_entry_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'time_tracking_event.dart';
part 'time_tracking_state.dart';

class Ticker {
  Stream<int> tick({int ticks = 0}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks + x + 1).take(ticks);
  }
}

class TimeTrackingBloc extends Bloc<TimeTrackingEvent, TimeTrackingState> {
  void _tick(int ticks) => add(TimeTrackingTickEvent(ticks));
  void startTimer({int? taskId}) => add(TimeTrackingStartEvent(taskId: taskId));
  void finish(TimeEntryEntity value) => add(TimeTrackingFinishEvent(value));

  TimeTrackingBloc(this._ticker) : super(const TimeTrackingState()) {
    on<TimeTrackingTickEvent>(_tickEvent);
    on<TimeTrackingStartEvent>(_startTimer);
    on<TimeTrackingFinishEvent>(_finish);
  }

  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;
  final _repository = sl<TimeEntryRepository>();

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _tickEvent(TimeTrackingTickEvent event, Emitter<TimeTrackingState> emit) {
    final result = DateTime.now().difference(state.startTime!).inSeconds;
    emit(state.copyWith(
      isFinished: result <= 0,
    ));
  }

  void _startTimer(TimeTrackingStartEvent event, Emitter<TimeTrackingState> emit) async {
    if (state.isLoading) return;
    if (state.startTime != null && !state.isFinished) {
      return emit(state.copyWith(
        error: 'Cannot start new entry, while existing is not finished',
      ));
    }

    emit(state.copyWith(isLoading: true));
    try {
      final now = DateTime.now();
      final response = await _repository.start(now, taskId: event.taskId);

      emit(TimerTrackingStartedState(
        startTime: response.startTime,
        taskId: event.taskId,
      ));

      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick().listen((ticks) => _tick(ticks));
    } catch (e) {
      debugPrint('TimeTrackingStartEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _finish(TimeTrackingFinishEvent event, Emitter<TimeTrackingState> emit) async {
    if (state.isLoading) return;
    if (state.startTime == null || state.isFinished) {
      return emit(state.copyWith(error: 'No started time entries exist'));
    }

    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.end(event.timeEntryEntity);
      emit(TimerTrackingFinishedState(response));
    } catch (e) {
      debugPrint('TimeTrackingFinishEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
