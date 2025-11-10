import 'package:ovavue/domain.dart';
import 'package:ovavue/presentation/state/registry_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_provider.g.dart';

/// Should only be used from the UI
@Riverpod(dependencies: [registry])
Analytics analytics(Ref ref) => ref.watch(registryProvider).get();
