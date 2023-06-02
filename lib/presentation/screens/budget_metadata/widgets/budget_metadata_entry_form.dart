import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ovavue/domain.dart';

import '../../../constants.dart';
import '../../../models.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import 'budget_metadata_value_vertical_divider.dart';

enum BudgetMetadataEntryType { create, update }

class BudgetMetadataEntryForm extends StatefulWidget {
  const BudgetMetadataEntryForm({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.values,
  });

  final BudgetMetadataEntryType type;
  final String? title;
  final String? description;
  final List<BudgetMetadataValueViewModel>? values;

  @override
  State<BudgetMetadataEntryForm> createState() => _BudgetMetadataEntryFormState();
}

class _BudgetMetadataEntryFormState extends State<BudgetMetadataEntryForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController = TextEditingController(text: widget.title ?? '');
  late final TextEditingController _descriptionController = TextEditingController(text: widget.description ?? '');

  late Set<_BudgetMetadataValueController> _values;

  @override
  void initState() {
    _values = _generateControllers(widget.values);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant BudgetMetadataEntryForm oldWidget) {
    if (!listEquals(widget.values, oldWidget.values)) {
      _values = _generateControllers(widget.values);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    for (final _BudgetMetadataValueController controller in _values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    const SizedBox spacing = SizedBox(height: 12.0);

    final bool creating = widget.type == BudgetMetadataEntryType.create;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0).withKeyboardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
            for (final _BudgetMetadataValueController controller in _values)
              if (controller.value case final BudgetMetadataValueEntryModifyResult value) ...<Widget>[
                _BudgetMetadataValueField(
                  key: ObjectKey(value),
                  initialValue: value,
                  onChanged: ((String, String) newValue) => controller.value = BudgetMetadataValueEntryModifyResult(
                    reference: value.reference,
                    title: newValue.$1,
                    value: newValue.$2,
                  ),
                  onRemoved: () => _handleRemoveValueType(value),
                ),
                spacing,
              ],
            TextButton(
              onPressed: _handleCreateValueType,
              child: Text(l10n.createNewMetadataValueType),
            ),
            spacing,
            PrimaryButton(
              caption: l10n.submitCaption,
              enabled: _values.where((_) => _.value is BudgetMetadataValueEntryModifyResult).isNotEmpty,
              onPressed: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Set<_BudgetMetadataValueController> _generateControllers(List<BudgetMetadataValueViewModel>? values) {
    return <_BudgetMetadataValueController>{
      for (final BudgetMetadataValueViewModel item in values ?? <BudgetMetadataValueViewModel>[])
        _BudgetMetadataValueController(
          BudgetMetadataValueEntryModifyResult(
            reference: (id: item.id, path: item.path),
            title: item.title,
            value: item.value,
          ),
        ),
    };
  }

  void _handleCreateValueType() {
    setState(() {
      _values = <_BudgetMetadataValueController>{
        ..._values,
        _BudgetMetadataValueController(
          const BudgetMetadataValueEntryModifyResult(
            reference: null,
            title: '',
            value: '',
          ),
        ),
      };
    });
  }

  void _handleRemoveValueType(BudgetMetadataValueEntryModifyResult item) {
    setState(() {
      _values = <_BudgetMetadataValueController>{
        ..._values.where((_) => _.value != item),
        if (item.reference case final ReferenceEntity reference)
          _BudgetMetadataValueController(
            BudgetMetadataValueEntryRemoveResult(
              reference,
            ),
          ),
      };
    });
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() == true) {
      Navigator.pop(
        context,
        BudgetMetadataEntryResult(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          values: _values.map((_) => _.value),
        ),
      );
    }
  }
}

class _BudgetMetadataValueController extends ValueNotifier<BudgetMetadataValueEntryResult> with EquatableMixin {
  _BudgetMetadataValueController(super.value);

  @override
  List<Object> get props => <Object>[value];
}

class _BudgetMetadataValueField extends StatefulWidget {
  const _BudgetMetadataValueField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.onRemoved,
  });

  final BudgetMetadataValueEntryModifyResult initialValue;

  final ValueChanged<(String, String)> onChanged;

  final VoidCallback onRemoved;

  @override
  State<_BudgetMetadataValueField> createState() => _BudgetMetadataValueFieldState();
}

class _BudgetMetadataValueFieldState extends State<_BudgetMetadataValueField> {
  late final TextEditingController _titleEditingController = TextEditingController(text: widget.initialValue.title);
  late final TextEditingController _valueEditingController = TextEditingController(text: widget.initialValue.value);
  late final Listenable _formChanges = Listenable.merge(<TextEditingController>[
    _titleEditingController,
    _valueEditingController,
  ]);

  @override
  void initState() {
    _formChanges.addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _valueEditingController.dispose();
    _formChanges.removeListener(_listener);

    super.dispose();
  }

  void _listener() => widget.onChanged((_titleEditingController.text, _valueEditingController.text));

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final L10n l10n = context.l10n;

    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _titleEditingController,
            decoration: InputDecoration(
              hintText: l10n.titleLabel,
              prefixIcon: const Icon(AppIcons.value),
            ),
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'\s?')),
            ],
            validator: (String? value) => _validator(value, l10n),
          ),
        ),
        const BudgetMetadataValueVerticalDivider(),
        Expanded(
          child: TextFormField(
            controller: _valueEditingController,
            decoration: InputDecoration(hintText: l10n.valueLabel),
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            validator: (String? value) => _validator(value, l10n),
          ),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: widget.onRemoved,
          icon: const Icon(AppIcons.delete),
          color: colorScheme.error,
        ),
      ],
    );
  }

  String? _validator(String? value, L10n l10n) =>
      value != null && value.length < 2 ? l10n.atLeastNCharactersShortErrorMessage(2) : null;
}

Future<BudgetMetadataEntryResult?> showBudgetMetadataEntryForm({
  required BuildContext context,
  required BudgetMetadataEntryType type,
  required String? title,
  required String? description,
  required List<BudgetMetadataValueViewModel>? values,
}) =>
    showDialogPage(
      context: context,
      builder: (_) => BudgetMetadataEntryForm(
        type: type,
        title: title,
        description: description,
        values: values,
      ),
    );

sealed class BudgetMetadataValueEntryResult {}

class BudgetMetadataValueEntryModifyResult with EquatableMixin implements BudgetMetadataValueEntryResult {
  const BudgetMetadataValueEntryModifyResult({
    required this.reference,
    required this.title,
    required this.value,
  });

  final ReferenceEntity? reference;
  final String title;
  final String value;

  @override
  List<Object?> get props => <Object?>[reference, title, value];
}

class BudgetMetadataValueEntryRemoveResult with EquatableMixin implements BudgetMetadataValueEntryResult {
  const BudgetMetadataValueEntryRemoveResult(this.reference);

  final ReferenceEntity reference;

  @override
  List<Object> get props => <Object>[reference];
}

class BudgetMetadataEntryResult {
  const BudgetMetadataEntryResult({
    required this.title,
    required this.description,
    required this.values,
  });

  final String title;
  final String description;
  final Iterable<BudgetMetadataValueEntryResult> values;
}
