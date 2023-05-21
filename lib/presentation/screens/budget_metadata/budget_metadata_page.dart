import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils.dart';
import '../../widgets.dart';

class BudgetMetadataPage extends StatefulWidget {
  const BudgetMetadataPage({super.key});

  @override
  State<BudgetMetadataPage> createState() => _BudgetMetadataPageState();
}

class _BudgetMetadataPageState extends State<BudgetMetadataPage> {
  @visibleForTesting
  static const Key dataViewKey = Key('dataViewKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return const _ContentDataView(
            key: dataViewKey,
          );
        },
        child: const LoadingView(),
      ),
    );
  }
}

class _ContentDataView extends StatelessWidget {
  const _ContentDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: Text(l10n.metadataPageTitle),
          asSliver: true,
          centerTitle: true,
        ),
      ],
    );
  }
}
