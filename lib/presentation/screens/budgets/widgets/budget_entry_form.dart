import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/models.dart';
import 'package:ovavue/presentation/state.dart';
import 'package:ovavue/presentation/utils.dart';
import 'package:ovavue/presentation/widgets.dart';

enum BudgetEntryType { create, update }

class BudgetEntryForm extends StatefulWidget {
  const BudgetEntryForm({
    super.key,
    required this.type,
    required this.budgetId,
    required this.index,
    required this.title,
    required this.description,
    required this.amount,
    required this.active,
    required this.startedAt,
    required this.endedAt,
    required this.createdAt,
  });

  final BudgetEntryType type;
  final String? budgetId;
  final int? index;
  final String? title;
  final String? description;
  final Money? amount;
  final bool? active;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;

  @override
  State<BudgetEntryForm> createState() => _BudgetEntryFormState();
}

class _BudgetEntryFormState extends State<BudgetEntryForm> {
  static final _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _budgetsFieldKey = GlobalKey(debugLabel: 'budgetsFieldKey');

  late int _index = _computeIndex(widget.index ?? 0);
  late String? _budgetId = widget.budgetId;
  late final _titleController = TextEditingController(text: widget.title ?? _deriveTitle(_index));
  late final _descriptionController = TextEditingController(text: widget.description ?? '');
  late final _amountController = TextEditingController(
    text: widget.amount?.editableTextValue ?? '',
  );
  late DateTime _startedAt = widget.startedAt ?? clock.now();
  late DateTime? _endedAt = widget.endedAt;
  late bool _activeState = widget.active ?? true;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const spacing = SizedBox(height: 12.0);

    final creating = widget.type == BudgetEntryType.create;
    final initialBudgetId = widget.budgetId;
    final selectedBudgetId = _budgetId;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0).withKeyboardPadding(context),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final Iterable<BudgetViewModel> budgets = ref.watch(budgetsProvider).value ?? const <BudgetViewModel>[];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                spacing,
                if (creating && initialBudgetId == null && budgets.isNotEmpty) ...<Widget>[
                  DropdownButtonFormField<String>(
                    key: _budgetsFieldKey,
                    initialValue: selectedBudgetId,
                    isExpanded: true,
                    decoration: InputDecoration(
                      prefixIcon: selectedBudgetId != null ? null : const Icon(AppIcons.budget),
                      hintText: context.l10n.selectBudgetTemplateCaption,
                    ),
                    items: <DropdownMenuItem<String>>[
                      for (final BudgetViewModel budget in budgets)
                        DropdownMenuItem<String>(
                          key: Key(budget.id),
                          value: budget.id,
                          child: _BudgetItem(title: budget.title, amount: budget.amount),
                        ),
                    ],
                    onChanged: (String? id) => _handleIdSelection(budgets, id),
                  ),
                  spacing,
                ],
                TextFormField(
                  autofocus: creating,
                  controller: _titleController,
                  maxLength: kTitleMaxCharacterLength,
                  decoration: InputDecoration(
                    hintText: l10n.titleLabel,
                    prefixIcon: const Icon(AppIcons.title),
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                ),
                spacing,
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 2,
                  maxLength: kDescriptionMaxCharacterLength,
                  decoration: InputDecoration(
                    hintText: l10n.descriptionLabel,
                    prefixIcon: const Icon(AppIcons.description),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
                spacing,
                TextFormField(
                  controller: _amountController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: l10n.amountLabel,
                    prefixIcon: const Icon(AppIcons.amount),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(Money.regExp),
                  ],
                  validator: (String? value) =>
                      value == null || Money.parse(value) <= Money.zero ? context.l10n.nonZeroAmountErrorMessage : null,
                ),
                spacing,
                DatePickerField(
                  initialValue: _startedAt,
                  hintText: l10n.startDateLabel,
                  onChanged: (DateTime date) => setState(() => _startedAt = date),
                ),
                spacing,
                DatePickerField(
                  initialValue: _endedAt,
                  hintText: l10n.endDateLabel,
                  onChanged: (DateTime date) => setState(() => _endedAt = date),
                ),
                if (creating && budgets.isNotEmpty) ...<Widget>[
                  spacing,
                  SwitchListTile.adaptive(
                    value: _activeState,
                    onChanged: (bool state) => setState(() => _activeState = !_activeState),
                    title: Text(l10n.makeActiveLabel),
                  ),
                ],
                spacing,
                PrimaryButton(
                  onPressed: _handleSubmit,
                  caption: l10n.submitCaption,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  int _computeIndex(int previousIndex) => _startedAt.year == widget.createdAt.year ? previousIndex + 1 : 1;

  String _deriveTitle(int index) => '${_startedAt.year}.${index.toString().padLeft(2, '0')}';

  void _handleSelection(BudgetViewModel budget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _budgetId = budget.id;
      _index = _computeIndex(budget.index);
      _titleController.text = _deriveTitle(_index);
      _descriptionController.text = budget.description;
      _amountController.text = budget.amount.editableTextValue;
      setState(() {});
    });
  }

  void _handleIdSelection(Iterable<BudgetViewModel> budgets, String? id) {
    if (id != null) {
      _handleSelection(budgets.firstWhere((BudgetViewModel e) => e.id == id));
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pop(
        context,
        BudgetEntryResult(
          fromBudgetId: _budgetId,
          index: _index,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          amount: Money.parse(_amountController.text.trim()),
          startedAt: _startedAt,
          endedAt: _endedAt,
          active: _activeState,
        ),
      );
    }
  }
}

class _BudgetItem extends StatelessWidget {
  const _BudgetItem({required this.title, required this.amount});

  final String title;
  final Money amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: <Widget>[
        const Icon(AppIcons.budget),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title.sentence(),
            maxLines: 1,
            style: theme.textTheme.bodyLarge,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '(${amount.formatted})',
          maxLines: 1,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

Future<BudgetEntryResult?> showBudgetEntryForm({
  required BuildContext context,
  required BudgetEntryType type,
  required String? budgetId,
  required int? index,
  required String? title,
  required Money? amount,
  required String? description,
  required bool? active,
  required DateTime? startedAt,
  required DateTime? endedAt,
  required DateTime createdAt,
}) => showDialogPage(
  context: context,
  builder: (_) => BudgetEntryForm(
    type: type,
    budgetId: budgetId,
    index: index,
    title: title,
    description: description,
    amount: amount,
    active: active,
    startedAt: startedAt,
    endedAt: endedAt,
    createdAt: createdAt,
  ),
);

class BudgetEntryResult {
  const BudgetEntryResult({
    required this.fromBudgetId,
    required this.index,
    required this.title,
    required this.description,
    required this.amount,
    required this.startedAt,
    required this.endedAt,
    required this.active,
  });

  final String? fromBudgetId;
  final int index;
  final String title;
  final String description;
  final Money amount;
  final DateTime startedAt;
  final DateTime? endedAt;
  final bool active;
}
