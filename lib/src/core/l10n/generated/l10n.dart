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
