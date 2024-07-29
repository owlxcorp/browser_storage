import 'package:browser_storage/web/storage.dart';

import 'package:web/web.dart' as web;

/// The session storage for web.
final Storage sessionStorage = _StorageWeb(web.window.sessionStorage);

/// The local storage for web.
final Storage localStorage = _StorageWeb(web.window.localStorage);

/// The session storage for web.
class _StorageWeb implements Storage {
  /// The session storage for web.
  _StorageWeb(this.storage);

  /// The session storage for web.
  final web.Storage storage;

  @override
  void clear() => storage.clear();

  @override
  String? getItem(String key) => storage.getItem(key);

  @override
  String? key(int index) => storage.key(index);

  @override
  int get length => storage.length;

  @override
  void removeItem(String key) => storage.removeItem(key);

  @override
  void setItem(String key, String value) => storage.setItem(key, value);
}
