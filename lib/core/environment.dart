import 'package:flutter/services.dart';
import 'package:universal_io/io.dart' as io;

enum Environment {
  mock,
  dev,
  prod,
  testing
  ;

  static Environment _derive() {
    if (io.Platform.environment.containsKey('FLUTTER_TEST')) {
      return testing;
    }

    if (Environment.values.asNameMap()[appFlavor] case final Environment env?) {
      return env;
    }

    throw UnimplementedError("Invalid runtime environment: '$appFlavor'. Available environments: ${values.join(', ')}");
  }

  bool get isMock => this == mock;

  bool get isDev => this == dev;

  bool get isProduction => this == prod;

  bool get isTesting => this == testing;

  bool get isDebugging {
    var condition = false;
    assert(() {
      condition = true;
      return condition;
    }(), 'Debugging is not enabled in release mode');
    return condition;
  }
}

Environment? _environment;

Environment get environment => _environment ??= Environment._derive();
