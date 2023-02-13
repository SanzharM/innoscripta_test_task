// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Board`
  String get board {
    return Intl.message(
      'Board',
      name: 'board',
      desc: '',
      args: [],
    );
  }

  /// `Boards`
  String get boards {
    return Intl.message(
      'Boards',
      name: 'boards',
      desc: '',
      args: [],
    );
  }

  /// `New board`
  String get newBoard {
    return Intl.message(
      'New board',
      name: 'newBoard',
      desc: '',
      args: [],
    );
  }

  /// `Board added`
  String get boardAdded {
    return Intl.message(
      'Board added',
      name: 'boardAdded',
      desc: '',
      args: [],
    );
  }

  /// `Board updated`
  String get boardUpdated {
    return Intl.message(
      'Board updated',
      name: 'boardUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Board deleted`
  String get boardDeleted {
    return Intl.message(
      'Board deleted',
      name: 'boardDeleted',
      desc: '',
      args: [],
    );
  }

  /// `How do you call your board?`
  String get howDoYouCallYourBoard {
    return Intl.message(
      'How do you call your board?',
      name: 'howDoYouCallYourBoard',
      desc: '',
      args: [],
    );
  }

  /// `New task`
  String get newTask {
    return Intl.message(
      'New task',
      name: 'newTask',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Task created`
  String get taskCreated {
    return Intl.message(
      'Task created',
      name: 'taskCreated',
      desc: '',
      args: [],
    );
  }

  /// `Task updated`
  String get taskUpdated {
    return Intl.message(
      'Task updated',
      name: 'taskUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Task deleted`
  String get taskDeleted {
    return Intl.message(
      'Task deleted',
      name: 'taskDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Task is done`
  String get taskDone {
    return Intl.message(
      'Task is done',
      name: 'taskDone',
      desc: '',
      args: [],
    );
  }

  /// `Change task status`
  String get changeTaskStatus {
    return Intl.message(
      'Change task status',
      name: 'changeTaskStatus',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message(
      'Deadline',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Create date`
  String get createdAt {
    return Intl.message(
      'Create date',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Last update date`
  String get lastUpdateDate {
    return Intl.message(
      'Last update date',
      name: 'lastUpdateDate',
      desc: '',
      args: [],
    );
  }

  /// `Time tracking`
  String get timeTracking {
    return Intl.message(
      'Time tracking',
      name: 'timeTracking',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Time tracking started`
  String get timeTrackingStarted {
    return Intl.message(
      'Time tracking started',
      name: 'timeTrackingStarted',
      desc: '',
      args: [],
    );
  }

  /// `Time tracking finished`
  String get timeTrackingFinished {
    return Intl.message(
      'Time tracking finished',
      name: 'timeTrackingFinished',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `List is empty`
  String get listIsEmpty {
    return Intl.message(
      'List is empty',
      name: 'listIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Themes`
  String get themes {
    return Intl.message(
      'Themes',
      name: 'themes',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Clear local storage`
  String get clearLocalStorage {
    return Intl.message(
      'Clear local storage',
      name: 'clearLocalStorage',
      desc: '',
      args: [],
    );
  }

  /// `All local data will be deleted`
  String get allLocalDataWillBeDeleted {
    return Intl.message(
      'All local data will be deleted',
      name: 'allLocalDataWillBeDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Time entry`
  String get timeEntry {
    return Intl.message(
      'Time entry',
      name: 'timeEntry',
      desc: '',
      args: [],
    );
  }

  /// `Time entries`
  String get timeEntries {
    return Intl.message(
      'Time entries',
      name: 'timeEntries',
      desc: '',
      args: [],
    );
  }

  /// `Time entry updated`
  String get timeEntryUpdated {
    return Intl.message(
      'Time entry updated',
      name: 'timeEntryUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Time entry deleted`
  String get timeEntryDeleted {
    return Intl.message(
      'Time entry deleted',
      name: 'timeEntryDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get startTime {
    return Intl.message(
      'Start time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get endTime {
    return Intl.message(
      'End time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Finish time`
  String get finishTime {
    return Intl.message(
      'Finish time',
      name: 'finishTime',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete?`
  String get sureDelete {
    return Intl.message(
      'Are you sure you want to delete?',
      name: 'sureDelete',
      desc: '',
      args: [],
    );
  }

  /// `Connect to another task`
  String get connectToAnotherTask {
    return Intl.message(
      'Connect to another task',
      name: 'connectToAnotherTask',
      desc: '',
      args: [],
    );
  }

  /// `Current time tracking`
  String get currentTimeTracking {
    return Intl.message(
      'Current time tracking',
      name: 'currentTimeTracking',
      desc: '',
      args: [],
    );
  }

  /// `Press "Play" button to start tracking`
  String get pressButtonToStartTracking {
    return Intl.message(
      'Press "Play" button to start tracking',
      name: 'pressButtonToStartTracking',
      desc: '',
      args: [],
    );
  }

  /// `Press here to add {something} to calendar`
  String pressToAddToCalendar(String something) {
    return Intl.message(
      'Press here to add $something to calendar',
      name: 'pressToAddToCalendar',
      desc: '',
      args: [something],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Generate report as CSV file`
  String get generateCsv {
    return Intl.message(
      'Generate report as CSV file',
      name: 'generateCsv',
      desc: '',
      args: [],
    );
  }

  /// `Export history time tracks`
  String get exportHistoryTimeTracks {
    return Intl.message(
      'Export history time tracks',
      name: 'exportHistoryTimeTracks',
      desc: '',
      args: [],
    );
  }

  /// `Export board`
  String get exportBoard {
    return Intl.message(
      'Export board',
      name: 'exportBoard',
      desc: '',
      args: [],
    );
  }

  /// `{value} hours`
  String totalHours(double value) {
    return Intl.message(
      '$value hours',
      name: 'totalHours',
      desc: '',
      args: [value],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
