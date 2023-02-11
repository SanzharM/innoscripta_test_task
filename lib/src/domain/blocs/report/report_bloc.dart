import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/services/share_media.dart';
import 'package:innoscripta_test_task/src/core/services/utils.dart';
import 'package:innoscripta_test_task/src/domain/entities/board/board_entity.dart';
import 'package:innoscripta_test_task/src/domain/entities/task/task_entity.dart';
import 'package:innoscripta_test_task/src/domain/repositories/board/board_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/task/task_repository.dart';
import 'package:innoscripta_test_task/src/domain/repositories/time_entry/time_entry_repository.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';
import 'package:path_provider/path_provider.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  void generateCsv(List<List<dynamic>> rows) => add(ReportGenerateCsvEvent(rows: rows));
  void generateBoardReport(int boardId) => add(ReportBoardEvent(boardId));

  ReportBloc() : super(ReportInitial()) {
    on<ReportGenerateCsvEvent>(_generateCsv);
    on<ReportBoardEvent>(_generateBoardReport);
  }

  void _generateCsv(ReportGenerateCsvEvent event, Emitter<ReportState> emit) async {
    emit(ReportLoadingState());

    try {
      String csv = const ListToCsvConverter().convert(event.rows);
      final fileCsv = await _writeStringIntoFile(
        data: csv,
        filename: 'Report ${Utils.formatDate(DateTime.now())}',
        format: 'csv',
      );
      await ShareMedia.share(fileCsv.path, 'file');
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ReportCsvGeneratedState());
    } catch (e) {
      debugPrint('ReportGenerateCsvEvent error: $e');
      emit(ReportErrorState(e.toString()));
    }
  }

  void _generateBoardReport(ReportBoardEvent event, Emitter<ReportState> emit) async {
    emit(ReportLoadingState());

    try {
      final board = await _getFullBoardEntity(event.boardId);
      var tasks = board.tasks.map((e) => e.toCsv()).toList();

      final List<List<dynamic>> rows = [
        BoardEntity.csvColumnNames,
        board.toCsv(),
        [],
        ['Tasks'],
        TaskEntity.csvColumnNames,
        ...tasks,
      ];
      return generateCsv(rows);
    } catch (e) {
      debugPrint('ReportBoardEvent error: $e');
      emit(ReportErrorState(e.toString()));
    }
  }

  Future<File> _writeStringIntoFile({
    required String data,
    required String filename,
    required String format,
  }) async {
    if (format.startsWith('.')) {
      format = format.replaceFirst('.', '');
    }

    final dir = await getTemporaryDirectory();
    File file = File('${dir.path}/$filename.$format');
    return await file.writeAsString(data);
  }

  Future<BoardEntity> _getFullBoardEntity(int boardId) async {
    final boardRepository = sl<BoardRepository>();
    final taskRepository = sl<TaskRepository>();
    final timeEntryRepository = sl<TimeEntryRepository>();

    BoardEntity boardEntity = await boardRepository.getBoard(boardId);
    var tasks = await taskRepository.getTasksFromBoard(boardId);
    for (int i = 0; i < tasks.length; i++) {
      final timeEntries = await timeEntryRepository.getEntries(taskId: tasks[i].id);
      tasks[i] = tasks[i].copyWith(timeEntries: timeEntries);
    }
    boardEntity = boardEntity.copyWith(tasks: tasks);
    return boardEntity;
  }
}
