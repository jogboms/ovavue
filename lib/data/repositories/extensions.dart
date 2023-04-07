import 'dart:math';

import 'package:clock/clock.dart';
import 'package:faker/faker.dart';

extension RandomGeneratorExtensions on RandomGenerator {
  DateTime get dateTime {
    final DateTime now = clock.now();
    final int year = now.year;
    final int month = now.month;
    return DateTime(
      integer(year, min: year),
      integer(min(month + 1, 12), min: max(month - 1, 0)),
      integer(29, min: 1),
      integer(23),
      integer(59),
    );
  }
}

extension RandomEnum<T extends Object> on Iterable<T> {
  T random() {
    if (isEmpty) {
      throw StateError('No element');
    }
    if (length == 1) {
      return elementAt(0);
    }
    return elementAt(Random().nextInt(length - 1));
  }
}
