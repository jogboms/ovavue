import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ovavue/presentation.dart';

class BudgetEntryForm extends StatefulWidget {
  const BudgetEntryForm({
    super.key,
    required this.budgetId,
    required this.index,
    required this.description,
    required this.amount,
    required this.createdAt,
  });

  final String? budgetId;
  final int index;
  final String? description;
  final Money? amount;
  final DateTime createdAt;

  @override
  State<BudgetEntryForm> createState() => _BudgetEntryFormState();
}

class _BudgetEntryFormState extends State<BudgetEntryForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _descriptionController = TextEditingController(
    text: widget.description ?? '',
  );
  late final TextEditingController _amountController = TextEditingController(
    text: widget.amount?.editableTextValue ?? '',
  );
  late final String? _budgetId = widget.budgetId; // TODO(jogboms): budget picker
  DateTime _startedAt = clock.now();
  bool _activeState = true;

  int get _index => _startedAt.year == widget.createdAt.year ? widget.index + 1 : 1;

  @override
  void initState() {
    final String title = '${_startedAt.year}.${_index.toString().padLeft(2, '0')}';
    _titleController.text = title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    const SizedBox spacing = SizedBox(height: 12.0);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            spacing,
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: l10n.titleLabel),
            ),
            spacing,
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: l10n.amountLabel),
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(Money.regExp),
              ],
            ),
            spacing,
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(labelText: l10n.descriptionLabel),
            ),
            spacing,
            DatePickerField(
              initialValue: clock.now(),
              labelText: l10n.startDateLabel,
              onChanged: (DateTime date) => setState(() => _startedAt = date),
            ),
            spacing,
            SwitchListTile.adaptive(
              value: _activeState,
              onChanged: (bool state) => setState(() => _activeState = !_activeState),
              title: Text(l10n.makeActiveLabel),
            ),
            spacing,
            FilledButton.tonal(
              onPressed: _handleSubmit,
              child: Text(l10n.submitCaption),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pop(
        context,
        BudgetEntryResult(
          fromBudgetId: _budgetId,
          index: _index,
          title: _titleController.text,
          description: _descriptionController.text,
          amount: Money.parse(_amountController.text),
          startedAt: _startedAt,
          active: _activeState,
        ),
      );
    }
  }
}

Future<BudgetEntryResult?> showBudgetEntryForm({
  required BuildContext context,
  required String? budgetId,
  required int index,
  required Money? amount,
  required String? description,
  required DateTime createdAt,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _DialogPage(
        (_) => BudgetEntryForm(
          budgetId: budgetId,
          index: index,
          description: description,
          amount: amount,
          createdAt: createdAt,
        ),
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
    required this.active,
  });

  final String? fromBudgetId;
  final int index;
  final String title;
  final String description;
  final Money amount;
  final DateTime startedAt;
  final bool active;
}

class _DialogPage extends StatelessWidget {
  const _DialogPage(this.builder);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(backgroundColor: colorScheme.inverseSurface),
          color: colorScheme.onInverseSurface,
          icon: const Icon(Icons.close),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Material(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              width: double.infinity,
              child: builder(context),
            ),
          ),
        ),
      ],
    );
  }
}
