import 'package:flutter_test/flutter_test.dart';
import 'package:ovavue/domain.dart';

void main() {
  group('AnalyticsEvent', () {
    test('should append event name with app', () {
      expect(AnalyticsEvent('name').name, 'app_name');
    });

    test('should serialize to string', () {
      expect(AnalyticsEvent('name').toString(), 'app_name');
      expect(
        AnalyticsEvent('name', {}).toString(),
        'app_name',
      );
      expect(
        AnalyticsEvent('name', {'1': 'one'}).toString(),
        'app_name: {1: one}',
      );
    });
  });
}
