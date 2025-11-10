import 'dart:math';

import 'package:clock/clock.dart';
import 'package:faker/faker.dart';

extension RandomGeneratorExtensions on RandomGenerator {
  DateTime get dateTime {
    final now = clock.now();
    final year = now.year;
    final month = now.month;
    return DateTime(
      integer(year, min: year),
      integer(min(month + 1, 12), min: max(month - 1, 0)),
      integer(29, min: 1),
      integer(23),
      integer(59),
    );
  }
}
