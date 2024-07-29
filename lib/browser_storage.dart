library browser_storage;

import 'package:browser_storage/storage_memory.dart'
    if (dart.library.js_interop) 'package:browser_storage/storage_web.dart'
    as interop;

import 'package:browser_storage/web/storage.dart';

/// An abstraction over [Map] that allows for SessionStorage to be used on
/// non-web platforms without issues.
abstract class _BrowserStorage implements Map<String, String> {
  abstract final Storage _instance;

  @override
  String? operator [](Object? key) =>
      key == null ? null : _instance.getItem(key as String);

  @override
  void operator []=(String key, String value) => _instance.setItem(key, value);

  @override
  void addAll(Map<String, String> other) => other.forEach(_instance.setItem);

  @override
  void addEntries(Iterable<MapEntry<String, String>> newEntries) {
    for (final entry in newEntries) {
      _instance.setItem(entry.key, entry.value);
    }
  }

  @override
  Map<RK, RV> cast<RK, RV>() =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  void clear() => _instance.clear();

  @override
  bool containsKey(Object? key) =>
      key != null && _instance.getItem(key as String) != null;

  @override
  bool containsValue(Object? value) =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  Iterable<MapEntry<String, String>> get entries =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  void forEach(void Function(String key, String value) action) =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  bool get isEmpty => length == 0;

  @override
  bool get isNotEmpty => length != 0;

  @override
  Iterable<String> get keys =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  int get length => _instance.length;

  @override
  Map<K2, V2> map<K2, V2>(
    MapEntry<K2, V2> Function(String key, String value) convert,
  ) =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  String putIfAbsent(String key, String Function() ifAbsent) =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  String? remove(Object? key) => key == null || !containsKey(key)
      ? null
      : (() {
          final item = _instance.getItem(key as String);
          _instance.removeItem(key);

          return item;
        })();

  @override
  void removeWhere(bool Function(String key, String value) test) =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  String update(
    String key,
    String Function(String value) update, {
    String Function()? ifAbsent,
  }) {
    final value = _instance.getItem(key);
    if (value == null) {
      if (ifAbsent != null) {
        final newValue = ifAbsent();
        _instance.setItem(key, newValue);

        return newValue;
      }

      throw StateError('Key $key not found');
    } else {
      final newValue = update(value);
      _instance.setItem(key, newValue);

      return newValue;
    }
  }

  @override
  void updateAll(String Function(String key, String value) update) =>
      throw UnsupportedError('JsStorage does not support this operation');

  @override
  Iterable<String> get values =>
      throw UnsupportedError('JsStorage does not support this operation');
}

/// A class that represents the BrowserStorage which implements Storage.
class BrowserStorage {
  static SessionStorage? _sessionStorage = SessionStorage();
  static LocalStorage? _localStorage = LocalStorage();

  /// The session storage for web.
  static SessionStorage get sessionStorage =>
      _sessionStorage ??= SessionStorage();

  /// The local storage for web.
  static LocalStorage get localStorage => _localStorage ??= LocalStorage();
}

/// A class that represents the SessionStorage which implements Storage.
class SessionStorage extends _BrowserStorage {
  @override
  final Storage _instance = interop.sessionStorage;
}

/// A class that represents the SessionStorage which implements Storage.
class LocalStorage extends _BrowserStorage {
  @override
  final Storage _instance = interop.localStorage;
}
