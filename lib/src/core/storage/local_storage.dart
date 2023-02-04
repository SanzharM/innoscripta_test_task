import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:innoscripta_test_task/src/service_locator.dart';

class LocalStorage {
  LocalStorage();

  final _storage = sl<FlutterSecureStorage>();

  FlutterSecureStorage get storage => _storage;
}
