import 'package:flutter/material.dart';

import 'package:ovavue/presentation/theme.dart';

Future<bool> showErrorChoiceBanner(
  BuildContext context, {
  required String message,
}) async {
  final theme = context.theme;
  final scaffoldMessengerState = ScaffoldMessenger.of(context)
    ..removeCurrentMaterialBanner(reason: MaterialBannerClosedReason.dismiss);

  final backgroundColor = theme.colorScheme.onError;

  final result = scaffoldMessengerState
      .showMaterialBanner(
        MaterialBanner(
          backgroundColor: theme.colorScheme.error,
          content: Text(message),
          contentTextStyle: theme.textTheme.bodyLarge?.copyWith(color: backgroundColor),
          actions: <Widget>[
            IconButton(
              onPressed: scaffoldMessengerState.removeCurrentMaterialBanner,
              icon: const Icon(Icons.check_outlined),
              color: backgroundColor,
            ),
            IconButton(
              onPressed: scaffoldMessengerState.hideCurrentMaterialBanner,
              icon: const Icon(Icons.close_outlined),
              color: backgroundColor,
            ),
          ],
        ),
      )
      .closed;

  return await result == MaterialBannerClosedReason.remove;
}
