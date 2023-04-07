import 'package:flutter/material.dart';

import '../../widgets.dart';

class ActiveBudgetPage extends StatefulWidget {
  const ActiveBudgetPage({super.key});

  @override
  State<ActiveBudgetPage> createState() => _ActiveBudgetPageState();
}

class _ActiveBudgetPageState extends State<ActiveBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar.empty,
      body: Placeholder(),
    );
  }
}
