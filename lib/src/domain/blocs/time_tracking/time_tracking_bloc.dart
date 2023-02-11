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
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks + x);
  }
}

class TimeTrackingBloc extends Bloc<TimeTrackingEvent, TimeTrackingState> {
  void initial() => add(TimeTrackingInitialEvent());
  void _tick() => add(TimeTrackingTickEvent());
  void startTimer({int? taskId}) => add(TimeTrackingStartEvent(taskId: taskId));
  void finish(TimeEntryEntity value) => add(TimeTrackingFinishEvent(value));

  TimeTrackingBloc(this._ticker) : super(const TimeTrackingState()) {
    on<TimeTrackingInitialEvent>(_initial);
    on<TimeTrackingTickEvent>(_tickEvent);
    on<TimeTrackingStartEvent>(_startTimer);
    on<TimeTrackingFinishEvent>(_finish);
  }

  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;
  final _repository = sl<TimeEntryRepository>();

  void _timerRestart() {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick().listen((_) => _tick());
    return;
  }

  Future<void> _timerFinish() async {
    return _tickerSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _initial(TimeTrackingInitialEvent event, Emitter<TimeTrackingState> emit) async {
    final allTimeEntries = await _repository.getEntries();

    TimeEntryEntity? globalTimeEntry;
    if (allTimeEntries.any((e) => e.isGlobal)) {
      globalTimeEntry = allTimeEntries.firstWhere((e) => e.isGlobal);
      _timerRestart();
    }

    return emit(state.copyWith(timeEntry: globalTimeEntry));
  }

  void _tickEvent(TimeTrackingTickEvent event, Emitter<TimeTrackingState> emit) {
    if (state.isNotActive) return;
    final result = DateTime.now().difference(state.timeEntry!.startTime).inSeconds;
    emit(state.copyWith(currentDuration: result));
  }

  void _startTimer(TimeTrackingStartEvent event, Emitter<TimeTrackingState> emit) async {
    if (state.isLoading) return;
    if (state.isActive) {
      const message = 'Cannot start new entry, while existing is not finished';
      return emit(state.copyWith(error: message));
    }

    emit(state.copyWith(isLoading: true));
    try {
      final now = DateTime.now();
      final response = await _repository.start(now, taskId: event.taskId, isGlobal: true);
      _timerRestart();

      emit(TimerTrackingStartedState(timeEntry: response, taskId: event.taskId));
    } catch (e) {
      debugPrint('TimeTrackingStartEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _finish(TimeTrackingFinishEvent event, Emitter<TimeTrackingState> emit) async {
    if (state.isLoading) return;

    if (state.isNotActive) {
      const message = 'No started time entries exist';
      return emit(state.copyWith(error: message));
    }

    if (state.timeEntry!.copyWith(endTime: DateTime.now()).isInvalid) {
      final response = await _repository.delete(state.timeEntry!);
      if (response) {
        emit(TimerTrackingFinishedState(timeEntry: state.timeEntry));
        emit(const TimeTrackingState());
      }
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.end(state.timeEntry!);

      _timerFinish();
      emit(TimerTrackingFinishedState(timeEntry: response));
    } catch (e) {
      debugPrint('TimeTrackingFinishEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
