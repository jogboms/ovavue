import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version_provider.g.dart';

/// Container for the application's version
/// Should be overridden per [ProviderScope]
@Riverpod(dependencies: <Object>[])
String appVersion(Ref ref) => throw UnimplementedError();
