import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/time_entry/time_entry_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/task/task_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/time_entry/time_entry_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

part 'time_entry_event.dart';
part 'time_entry_state.dart';

class TimeEntryBloc extends Bloc<TimeEntryEvent, TimeEntryState> {
  void get() => add(TimeEntryGetEvent());
  void update(TimeEntryEntity value) => add(TimeEntryUpdateEvent(value));
  void delete(TimeEntryEntity value) => add(TimeEntryDeleteEvent(value));

  TimeEntryBloc(TimeEntryEntity timeEntry) : super(TimeEntryState(timeEntry: timeEntry)) {
    on<TimeEntryGetEvent>(_get);
    on<TimeEntryUpdateEvent>(_update);
    on<TimeEntryDeleteEvent>(_delete);
  }

  final _repository = sl<TimeEntryRepository>();
  final _taskRepository = sl<TaskRepository>();

  void _get(TimeEntryGetEvent event, Emitter<TimeEntryState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.getEntries();
      if (response.contains(state.timeEntry)) {
        final matchingTimeEntry = response.firstWhere((e) => e == state.timeEntry);
        emit(state.copyWith(isLoading: false, timeEntry: matchingTimeEntry));

        if (matchingTimeEntry.taskId != null) {
          final task = await _taskRepository.getTask(matchingTimeEntry.taskId!);
          emit(state.copyWith(taskEntity: task));
        }
        return;
      }
      emit(state.copyWith(isLoading: false, error: 'Time entry not found.'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _update(TimeEntryUpdateEvent event, Emitter<TimeEntryState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.update(event.timeEntryEntity);
      if (response) {
        return emit(TimeEntryUpdatedState(
          timeEntry: event.timeEntryEntity,
          taskEntity: state.taskEntity,
        ));
      }
      emit(state.copyWith(isLoading: false, error: 'Something went wrong'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _delete(TimeEntryDeleteEvent event, Emitter<TimeEntryState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    try {
      final response = await _repository.delete(event.timeEntryEntity);
      if (response) {
        return emit(TimeEntryDeletedState(
          timeEntry: event.timeEntryEntity,
          taskEntity: state.taskEntity,
        ));
      }
      emit(state.copyWith(isLoading: false, error: 'Something went wrong'));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
