import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';

import '../../mocks.dart';

void main() {
  group('ErrorReporter', () {
    final ReporterClient client = MockReporterClient();
    late ErrorReporter reporter;

    setUpAll(() {
      registerFallbackValue(FakeStackTrace());
      registerFallbackValue(FakeFlutterErrorDetails());
    });

    setUp(() {
      reporter = ErrorReporter(client: client);
    });

    tearDown(() => reset(client));

    test('should log with client', () {
      reporter.log('log');

      verify(() => client.log('log')).called(1);
    });

    test('should report with client', () {
      final exception = Exception();
      reporter.report(exception, StackTrace.empty);

      verify(
        () => client.report(
          error: exception,
          stackTrace: StackTrace.empty,
          extra: any(named: 'extra'),
        ),
      ).called(1);
    });

    test('should report with delay', () {
      fakeAsync((FakeAsync async) {
        final exception = Exception();
        reporter.report(exception, StackTrace.empty);
        async.elapse(const Duration(seconds: 5));
        reporter.report(exception, StackTrace.empty);
        async.elapse(const Duration(seconds: 10));
        reporter.report(exception, StackTrace.empty);

        verify(
          () => client.report(
            error: exception,
            stackTrace: StackTrace.empty,
            extra: any(named: 'extra'),
          ),
        ).called(2);
      });
    });

    test('should log error when report fails', () {
      final reportException = Exception();
      when(
        () => client.report(
          stackTrace: any(named: 'stackTrace'),
          error: any(named: 'error'),
        ),
      ).thenThrow(reportException);

      final exception = Exception();
      reporter.report(exception, StackTrace.empty);

      verify(
        () => client.report(
          error: exception,
          stackTrace: StackTrace.empty,
          extra: any(named: 'extra'),
        ),
      ).called(1);
      verify(() => client.log(reportException)).called(1);
    });

    test('should report crash with client', () {
      final errorDetails = FakeFlutterErrorDetails();
      reporter.reportCrash(errorDetails);

      verify(() => client.reportCrash(errorDetails)).called(1);
    });
  });
}

class MockReporterClient extends Mock implements ReporterClient {}
