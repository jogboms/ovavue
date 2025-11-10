import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets/budget_category_avatar.dart';

class BudgetAllocationEntryForm extends StatefulWidget {
  const BudgetAllocationEntryForm({
    super.key,
    required this.allocation,
    required this.plan,
    required this.budgetId,
    required this.plansById,
  });

  final Money? allocation;
  final BudgetPlanViewModel? plan;
  final String budgetId;
  final Iterable<String> plansById;

  @override
  State<BudgetAllocationEntryForm> createState() => _BudgetAllocationEntryFormState();
}

class _BudgetAllocationEntryFormState extends State<BudgetAllocationEntryForm> {
  static final _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _plansFieldKey = GlobalKey(debugLabel: 'plansFieldKey');
  static const _createPlanButtonKey = Key('createPlanButtonKey');

  late final _amountFocusNode = FocusNode(debugLabel: 'amount');

  late final _selectedPlan = ValueNotifier<BudgetPlanViewModel?>(widget.plan);
  late final _amountController = TextEditingController(
    text: widget.allocation?.editableTextValue ?? '',
  );

  Money get _textAsMoney => Money.parse(_amountController.text);

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final initialPlan = widget.plan;
    final selectedPlan = _selectedPlan.value;

    return Container(
      margin: EdgeInsets.fromLTRB(
        16.0,
        0,
        16.0,
        MediaQuery.paddingOf(context).bottom + 16.0,
      ).withKeyboardPadding(context),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final budgetRemainderAmount = ref.watch(
              selectedBudgetProvider(widget.budgetId).select(
                (AsyncValue<BudgetState> e) => e.requireValue.budget.amount - e.requireValue.allocation,
              ),
            );
            final allocationAmount = widget.allocation ?? Money.zero;
            final remainderAmount = budgetRemainderAmount + allocationAmount;

            final plans =
                ref
                    .watch(budgetPlansProvider)
                    .value
                    ?.where((BudgetPlanViewModel e) => !widget.plansById.contains(e.id)) ??
                const <BudgetPlanViewModel>[];

            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (initialPlan == null) ...<Widget>[
                    Builder(
                      builder: (BuildContext context) {
                        if (plans.isEmpty) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              key: _createPlanButtonKey,
                              onPressed: () => _handlePlanCreation(ref),
                              icon: const Icon(AppIcons.addPlan),
                              label: Text(context.l10n.createPlanCaption),
                            ),
                          );
                        }

                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: plans.length == 1
                                  ? Builder(
                                      builder: (_) {
                                        final plan = plans.first;
                                        _handlePlanSelection(plan);
                                        return _PlanItem(key: Key(plan.id), plan: plans.first);
                                      },
                                    )
                                  : DropdownButtonFormField<String>(
                                      key: _plansFieldKey,
                                      initialValue: selectedPlan?.id,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        prefixIcon: selectedPlan?.id != null ? null : const Icon(AppIcons.plans),
                                        hintText: context.l10n.selectPlanCaption,
                                      ),
                                      items: <DropdownMenuItem<String>>[
                                        for (final BudgetPlanViewModel plan in plans)
                                          DropdownMenuItem<String>(
                                            key: Key(plan.id),
                                            value: plan.id,
                                            child: _PlanItem(plan: plan),
                                          ),
                                      ],
                                      onChanged: (String? id) => _handlePlanIdSelection(plans, id),
                                    ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              key: _createPlanButtonKey,
                              onPressed: () => _handlePlanCreation(ref),
                              icon: const Icon(AppIcons.addPlan),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  ListenableBuilder(
                    listenable: _selectedPlan,
                    builder: (BuildContext context, Widget? amountCounter) => TextFormField(
                      focusNode: _amountFocusNode,
                      controller: _amountController,
                      autofocus: initialPlan != null || plans.length == 1,
                      enabled: _selectedPlan.value != null || plans.length == 1,
                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _handleSubmit,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(Money.regExp),
                      ],
                      validator: (_) =>
                          _textAsMoney > remainderAmount ? context.l10n.notEnoughBudgetAmountErrorMessage : null,
                      decoration: InputDecoration(
                        counter: amountCounter,
                        hintText: l10n.amountLabel,
                        prefixIcon: const Icon(AppIcons.amount),
                      ),
                    ),
                    child: ListenableBuilder(
                      listenable: _amountController,
                      builder: (BuildContext context, _) => Text(
                        context.l10n.amountRemainingCaption('${remainderAmount - _textAsMoney}'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handlePlanCreation(WidgetRef ref) async {
    final id = await createBudgetPlanAction(
      context: context,
      ref: ref,
      navigateOnComplete: false,
    );
    if (id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _plansFieldKey.currentState?.didChange(id);
      });
    }
  }

  void _handlePlanSelection(BudgetPlanViewModel plan) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedPlan.value = plan;
      _amountFocusNode.requestFocus();
    });
  }

  void _handlePlanIdSelection(Iterable<BudgetPlanViewModel> plans, String? id) {
    if (id != null) {
      _selectedPlan.value = plans.firstWhere((BudgetPlanViewModel e) => e.id == id);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _amountFocusNode.requestFocus();
      });
    }
  }

  void _handleSubmit() {
    final plan = _selectedPlan.value;
    if (plan != null && _formKey.currentState?.validate() == true) {
      Navigator.pop(context, BudgetAllocationEntryResult(_textAsMoney, plan));
    }
  }
}

class _PlanItem extends StatelessWidget {
  const _PlanItem({super.key, required this.plan});

  final BudgetPlanViewModel plan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: <Widget>[
        BudgetCategoryAvatar.small(
          colorScheme: plan.category.colorScheme,
          icon: plan.category.icon.data,
        ),
        const SizedBox(width: 8),
        Text(
          plan.title.sentence(),
          maxLines: 1,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

Future<BudgetAllocationEntryResult?> showBudgetAllocationEntryForm({
  required BuildContext context,
  required String budgetId,
  required Iterable<String> plansById,
  required BudgetPlanViewModel? plan,
  required Money? allocation,
}) async {
  final result = await showModalBottomSheet<BudgetAllocationEntryResult>(
    context: context,
    builder: (_) => BudgetAllocationEntryForm(
      allocation: allocation,
      plan: plan,
      budgetId: budgetId,
      plansById: plansById,
    ),
  );
  if (result == null) {
    return null;
  }

  return result;
}

class BudgetAllocationEntryResult {
  const BudgetAllocationEntryResult(this.amount, this.plan);

  final Money amount;
  final BudgetPlanViewModel plan;
}
