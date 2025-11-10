import 'package:registry/registry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registry_provider.g.dart';

/// Container for Registry/Service locator
/// Should be overridden per [ProviderScope]
@Riverpod(dependencies: [])
Registry registry(Ref ref) => throw UnimplementedError();
