part of 'report_bloc.dart';

@immutable
abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoadingState extends ReportState {}

class ReportErrorState extends ReportState {
  final String error;

  ReportErrorState(this.error);
}

class ReportCsvGeneratedState extends ReportState {}
