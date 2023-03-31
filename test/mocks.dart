import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockValueChangedCallback<T> extends Mock {
  void call(T data);
}

class MockAsyncCallback<T> extends Mock {
  Future<T> call();
}

class FakeRoute extends Fake implements Route<dynamic> {}

class FakeStackTrace extends Fake implements StackTrace {}

class FakeFlutterErrorDetails extends Fake implements FlutterErrorDetails {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return toDiagnosticsNode(style: DiagnosticsTreeStyle.error).toStringDeep(minLevel: minLevel);
  }
}
