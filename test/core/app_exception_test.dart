import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/core.dart';

void main() {
  group('AppException', () {
    test('should be equal when equal', () {
      expect(
        AppException(nonconst('message')),
        AppException(nonconst('message')),
      );
      expect(
        AppException(nonconst('message')).hashCode,
        AppException(nonconst('message')).hashCode,
      );
    });

    test('should serialize to string', () {
      expect(
        const AppException('message').toString(),
        'AppException{message: message}',
      );
    });
  });
}
