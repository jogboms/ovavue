import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/core.dart';

import '../../mocks.dart';

void main() {
  group('ErrorBoundary', () {
    setUpAll(() {
      registerFallbackValue(FakeStackTrace());
      registerFallbackValue(FakeFlutterErrorDetails());
    });

    testWidgets('should work as expected without errors', (WidgetTester tester) async {
      const Key childKey = Key('child');
      const Key errorViewKey = Key('errorView');

      final MockCrashHandler crashHandler = MockCrashHandler();
      final MockExceptionHandler exceptionHandler = MockExceptionHandler();

      await tester.pumpWidget(
        ErrorBoundary(
          errorViewBuilder: (_) => const SizedBox.shrink(key: errorViewKey),
          onCrash: crashHandler,
          onException: exceptionHandler,
          child: const SizedBox.shrink(key: childKey),
        ),
      );

      await tester.pump();

      expect(find.byKey(childKey), findsOneWidget);
      expect(find.byKey(errorViewKey), findsNothing);
    });

    testWidgets('should trigger onCrash', (WidgetTester tester) async {
      const Key childKey = Key('child');
      const Key errorViewKey = Key('errorView');

      final MockCrashHandler crashHandler = MockCrashHandler();
      final MockExceptionHandler exceptionHandler = MockExceptionHandler();

      await tester.pumpWidget(
        ErrorBoundary(
          errorViewBuilder: (_) => const SizedBox.shrink(key: errorViewKey),
          onCrash: crashHandler,
          onException: exceptionHandler,
          isReleaseMode: true,
          child: Builder(key: childKey, builder: (_) => throw Exception()),
        ),
      );

      await tester.pump();

      verifyNever(() => exceptionHandler.call(any(), any()));
      verify(() => crashHandler.call(any())).called(1);

      expect(find.byKey(childKey), findsOneWidget);
      expect(find.byKey(errorViewKey), findsOneWidget);
    });

    testWidgets('should not override error handler in non-release mode', (WidgetTester tester) async {
      const Key childKey = Key('child');
      const Key errorViewKey = Key('errorView');

      final MockCrashHandler crashHandler = MockCrashHandler();
      final MockExceptionHandler exceptionHandler = MockExceptionHandler();

      await tester.pumpWidget(
        ErrorBoundary(
          errorViewBuilder: (_) => const SizedBox.shrink(key: errorViewKey),
          onCrash: crashHandler,
          onException: exceptionHandler,
          child: Builder(key: childKey, builder: (_) => throw Exception()),
        ),
      );

      await tester.pump();

      expect(tester.takeException().toString(), '${Exception()}');

      verifyNever(() => exceptionHandler.call(any(), any()));
      verifyNever(() => crashHandler.call(any()));

      expect(find.byKey(childKey), findsOneWidget);
      expect(find.byKey(errorViewKey), findsNothing);
    });

    // TODO(Jogboms): No proper way to test PlatformDispatcher errors yet
    testWidgets(
      'should trigger onException',
      (WidgetTester tester) async {
        const Key childKey = Key('child');
        const Key errorViewKey = Key('errorView');

        final MockCrashHandler crashHandler = MockCrashHandler();
        final MockExceptionHandler exceptionHandler = MockExceptionHandler();

        await tester.pumpWidget(
          ErrorBoundary(
            platformDispatcher: tester.binding.platformDispatcher,
            errorViewBuilder: (_) => const SizedBox.shrink(key: errorViewKey),
            onCrash: crashHandler,
            onException: exceptionHandler,
            isReleaseMode: true,
            child: MaterialApp(
              home: GestureDetector(
                key: childKey,
                onTap: () async {
                  await const MethodChannel('crash').invokeMethod<void>('yes');
                },
                child: const Text('Tap'),
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byKey(childKey), findsOneWidget);
        await tester.tap(find.byKey(childKey));

        await tester.pumpAndSettle();

        verify(() => exceptionHandler.call(any(), any())).called(1);
        verifyNever(() => crashHandler.call(any()));

        expect(find.byKey(childKey), findsOneWidget);
        expect(find.byKey(errorViewKey), findsOneWidget);
      },
      skip: true,
    );
  });
}

class MockCrashHandler extends Mock {
  void call(FlutterErrorDetails details);
}

class MockExceptionHandler extends Mock {
  void call(Object error, StackTrace stackTrace);
}
