import 'package:browser_storage/storage.dart';
import 'package:flutter_test/flutter_test.dart';

const en = 'en';
const pt = 'pt';

const english = 'english';
const portuguese = 'portuguese';

void main() {
  group('LocalStorage', () {
    setUp(() => LocalStorage().clear());

    test('should return same value regardless of instance', () {
      final s1 = LocalStorage();
      final s2 = LocalStorage();

      s1[en] = english;
      s2[pt] = portuguese;

      expect(s1[en], english);
      expect(s1[pt], portuguese);
      expect(s2[en], english);
      expect(s2[pt], portuguese);
    });

    test('operators []= and [] should assign and retrieve value', () {
      final session = LocalStorage();

      session[en] = english;

      expect(session[en], english);
    });

    test('.addAll should add all values', () {
      final session = LocalStorage();

      session[en] = 'default';

      session.addAll({en: english, pt: portuguese});

      expect(session[en], english);
      expect(session[pt], portuguese);
    });

    test('.addEntries should add all values', () {
      final session = LocalStorage();

      session[en] = 'default';

      session.addEntries({en: english, pt: portuguese}.entries);

      expect(session[en], english);
      expect(session[pt], portuguese);
    });

    test('.cast should cast to valid value', () {
      final session = LocalStorage();

      final cast = session.cast<Object, Object>();

      cast[en] = 'default';

      expect(cast[en], 'default');
      expect(cast, isA<Map<Object, Object>>());
    });

    test('.clear should remove all values', () {
      final session = LocalStorage();

      session[en] = english;

      expect(session[en], english);

      session.clear();

      expect(session[en], null);
    });

    test('.containsKey should return correct values', () {
      final session = LocalStorage();

      expect(session.containsKey(en), false);

      session[en] = english;

      expect(session.containsKey(en), true);
    });

    test('.containsValue should return correct values', () {
      final session = LocalStorage();

      expect(session.containsValue(english), false);

      session[en] = english;

      expect(session.containsValue(english), true);
    });

    test('.entries should return array of MapEntry', () {
      final session = LocalStorage()..addAll({en: english, pt: portuguese});

      final entries = session.entries;

      expect(entries.firstWhere((e) => e.key == en).value, english);
      expect(entries.firstWhere((e) => e.key == pt).value, portuguese);
    });

    test('.forEach should go through all values', () {
      final order = <String>[];

      LocalStorage()
        ..addAll({en: english, pt: portuguese})
        ..forEach(
          (key, value) => order
            ..add(key)
            ..add(value),
        );

      expect(order, containsAll(<String>[en, english, pt, portuguese]));
    });

    test('.isEmpty and .isNotEmpty should return correct values', () {
      final session = LocalStorage();

      expect(session.isEmpty, true);
      expect(session.isNotEmpty, false);

      session.addAll({en: english, pt: portuguese});

      expect(session.isEmpty, false);
      expect(session.isNotEmpty, true);
    });

    test('.keys should return all keys', () {
      final session = LocalStorage()..addAll({en: english, pt: portuguese});

      expect(session.keys, containsAll(<String>[en, pt]));
    });

    test('.length should return correct length', () {
      final session = LocalStorage()..addAll({en: english, pt: portuguese});

      expect(session.length, 2);
    });

    test('.map should be able to change all keys and values', () {
      final session = LocalStorage()..addAll({en: english, pt: portuguese});

      final mapped = session.map<int, bool>(
        (key, value) => MapEntry(
          key == en ? 1 : 2,
          value == english,
        ),
      );

      expect(mapped[1], true);
      expect(mapped[2], false);
    });

    group('.putIfAbsent', () {
      test('should put key if it does not exist', () {
        final session = LocalStorage()
          ..addAll({en: english})
          ..putIfAbsent(pt, () => portuguese);

        expect(session[pt], portuguese);
      });

      test('should ignore put if key exists', () {
        final session = LocalStorage()
          ..addAll({en: english})
          ..putIfAbsent(en, () => 'default');

        expect(session[en], english);
      });
    });

    group('.remove', () {
      test('should remove existing key', () {
        final session = LocalStorage()..addAll({en: english, pt: portuguese});

        expect(session[pt], portuguese);

        session.remove(pt);

        expect(session[pt], null);
      });

      test('should do nothing on invalid key', () {
        final session = LocalStorage()
          ..addAll({en: english, pt: portuguese})
          ..remove('de');

        expect(session[pt], portuguese);
        expect(session[en], english);
      });
    });

    test('.removeWhere should remove existing value based on where', () {
      final session = LocalStorage()..addAll({en: english, pt: portuguese});

      expect(session[en], english);
      expect(session[pt], portuguese);

      session.removeWhere((key, value) => value == portuguese);

      expect(session[en], english);
      expect(session[pt], null);
    });

    group('.update', () {
      test('should update key if it exists', () {
        final session = LocalStorage()..addAll({en: english, pt: portuguese});

        expect(session[en], english);

        session.update(en, (value) => 'updated_$value');

        expect(session[en], 'updated_english');
      });

      test(
        'should add key if it does not exist and ifAbsent function passed',
        () {
          final session = LocalStorage()..addAll({en: english, pt: portuguese});

          expect(session['de'], null);

          session.update(
            'de',
            (value) => 'updated_$value',
            ifAbsent: () => 'german',
          );

          expect(session['de'], 'german');
        },
      );

      test(
        'should throw if key does not exist and there is no ifAbsent function',
        () {
          final session = LocalStorage()..addAll({en: english, pt: portuguese});

          void shouldThrow() => session.update(
                'de',
                (value) => 'updated_$value',
              );

          expect(shouldThrow, throwsArgumentError);
        },
      );
    });

    test(
      '.updateAll should update values based on provided function',
      () {
        final session = LocalStorage()..addAll({en: english, pt: portuguese});

        expect(session[en], english);
        expect(session[pt], portuguese);

        session.updateAll((key, value) => key == en ? 'updated_$value' : value);

        expect(session[en], 'updated_english');
        expect(session[pt], portuguese);
      },
    );

    test(
      '.values should return all values',
      () {
        final session = LocalStorage()..addAll({en: english, pt: portuguese});

        expect(
          session.values,
          containsAll(<String>[english, portuguese]),
        );
      },
    );
  });
}
