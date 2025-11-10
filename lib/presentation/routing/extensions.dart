import 'package:flutter/widgets.dart';

import 'package:ovavue/presentation/routing/app_router.dart';

extension AppRouterBuildContextExtension on BuildContext {
  AppRouter get router => AppRouter(this);
}
