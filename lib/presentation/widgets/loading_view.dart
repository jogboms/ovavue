import 'package:flutter/widgets.dart';

import 'loading_spinner.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  static const Key loadingViewKey = Key('loadingViewKey');

  @override
  Widget build(BuildContext context) => Center(
        key: loadingViewKey,
        child: LoadingSpinner.circle(),
      );
}
