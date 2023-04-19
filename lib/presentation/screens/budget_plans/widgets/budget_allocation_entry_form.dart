import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models.dart';
import '../../../state.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class BudgetAllocationEntryForm extends StatefulWidget {
  const BudgetAllocationEntryForm({
    super.key,
    required this.allocation,
    required this.plan,
    required this.budgetId,
  });

  final Money? allocation;
  final BudgetPlanViewModel plan;
  final String budgetId;

  @override
  State<BudgetAllocationEntryForm> createState() => _BudgetAllocationEntryFormState();
}

class _BudgetAllocationEntryFormState extends State<BudgetAllocationEntryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller = TextEditingController(
    text: widget.allocation?.editableTextValue ?? '',
  );

  Money get _textAsMoney => Money.parse(_controller.text);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
        bottom: mediaQuery.viewInsets.bottom + mediaQuery.padding.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Consumer(
          child: const LoadingView(),
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final Money budgetRemainderAmount = ref.watch(
              selectedBudgetProvider(widget.budgetId).select(
                (_) => _.requireValue.budget.amount - _.requireValue.allocation,
              ),
            );
            final Money allocationAmount = widget.allocation ?? Money.zero;
            final Money remainderAmount = budgetRemainderAmount + allocationAmount;

            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                controller: _controller,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                textInputAction: TextInputAction.done,
                onEditingComplete: _handleSubmit,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(Money.regExp),
                ],
                validator: (_) =>
                    _textAsMoney > remainderAmount ? context.l10n.notEnoughBudgetAmountErrorMessage : null,
                decoration: InputDecoration(
                  counter: ListenableBuilder(
                    listenable: _controller,
                    builder: (BuildContext context, _) => Text(
                      context.l10n.amountRemainingCaption('${remainderAmount - _textAsMoney}'),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pop(context, _textAsMoney);
    }
  }
}
