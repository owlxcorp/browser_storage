import 'package:browser_storage/web/storage.dart';

/// A generic session storage.
final Storage sessionStorage = StorageMemory();

/// A generic local storage.
final Storage localStorage = StorageMemory();

/// A class that represents the Storage which implements Storage.
class StorageMemory extends Storage {
  /// The session storage for web.
  StorageMemory({Map<String, String>? map}) : storage = map ?? {};

  /// The session storage for web.
  final Map<String, String> storage;

  @override
  void clear() => storage.clear();

  @override
  String? getItem(String key) => storage[key];

  @override
  String? key(int index) => storage.keys.elementAt(index);

  @override
  int get length => storage.length;

  @override
  void removeItem(String key) => storage.remove(key);

  @override
  void setItem(String key, String value) => storage[key] = value;
}
