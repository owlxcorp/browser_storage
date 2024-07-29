/// The **`Storage`** interface of the
/// [Web Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API)
/// provides access to a particular domain's session or local storage. It
/// allows, for example, the addition, modification, or deletion of stored data
/// items.

abstract class Storage {
  /// The **`key()`** method of the [Storage] interface,
  /// when passed a number n, returns the name of the nth key in a given
  /// `Storage`
  /// object. The order of keys is user-agent defined, so you should not rely on
  /// it.
  String? key(int index);

  /// The **`getItem()`** method of the [Storage]
  /// interface, when passed a key name, will return that key's value, or `null`
  /// if
  /// the key does not exist, in the given `Storage` object.
  String? getItem(String key);

  /// The **`setItem()`** method of the [Storage]
  /// interface, when passed a key name and value, will add that key to the
  /// given
  /// `Storage` object, or update that key's value if it already exists.
  void setItem(
    String key,
    String value,
  );

  /// The **`removeItem()`** method of the [Storage]
  /// interface, when passed a key name, will remove that key from the given
  /// `Storage` object if it exists.
  /// The **`Storage`** interface of the
  /// [Web Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API)
  /// provides access to a
  /// particular domain's session or local storage.
  ///
  /// If there is no item associated with the given key, this method will do
  /// nothing.
  void removeItem(String key);

  /// The **`clear()`** method of the [Storage]
  /// interface clears all keys stored in a given `Storage` object.
  void clear();

  /// The **`length`** read-only property of the [Storage].
  int get length;
}
