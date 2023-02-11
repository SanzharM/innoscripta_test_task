part of 'report_bloc.dart';

@immutable
abstract class ReportEvent {}

class ReportGenerateCsvEvent extends ReportEvent {
  final List<List<dynamic>> rows;

  ReportGenerateCsvEvent({
    required this.rows,
  });
}

class ReportBoardEvent extends ReportEvent {
  final int boardId;

  ReportBoardEvent(this.boardId);
}
