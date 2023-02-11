import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/time_entry/time_entry_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'time_tracking_history_event.dart';
part 'time_tracking_history_state.dart';

class TimeTrackingHistoryBloc extends Bloc<TimeTrackingHistoryEvent, TimeTrackingHistoryState> {
  void reset() => add(TimeTrackingHistoryResetEvent());
  void fetch() => add(TimeTrackingHistoryFetchEvent());

  TimeTrackingHistoryBloc() : super(const TimeTrackingHistoryState()) {
    on<TimeTrackingHistoryResetEvent>(_reset);
    on<TimeTrackingHistoryFetchEvent>(_fetch);
  }

  final _repository = sl<TimeEntryRepository>();

  void _reset(TimeTrackingHistoryResetEvent event, Emitter<TimeTrackingHistoryState> emit) {
    emit(const TimeTrackingHistoryState());
  }

  void _fetch(TimeTrackingHistoryFetchEvent event, Emitter<TimeTrackingHistoryState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final response = await _repository.getEntries();
      emit(state.copyWith(isLoading: false, timeEntries: response));
    } catch (e) {
      debugPrint('TimeTrackingHistoryFetchEvent error: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
