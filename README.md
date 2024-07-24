# browser_storage

## Getting Started

This is a very simple abstraction over a Map to allow usage of Storage on any platform, but specifically intended to interact with window.sessionStorage and window.localStorage on web without breaking other platforms. Based on https://github.com/JCQuintas/session_storage.

### Programmatically

Install the library using your preferred method.

```bash
flutter pub add browser_storage
```

Then use the library, the `SessionStorage` and `LocalStorage` classes only exposes a single constructor, and it always shares the same static instance.

```dart
import 'package:browser_storage/storage.dart';

final session = SessionStorage();
final local = LocalStorage();

// Use it like you would any other Map.
session['language'] = 'english';
local['language'] = 'english';

// Sessions are shared, so by calling the constructor again
// you will still have any value you previously set.
final newSession = SessionStorage();

newSession['language'] == 'english' // true
```
