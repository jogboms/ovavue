import 'package:flutter/material.dart';
import 'package:ovavue/core.dart';

import '../constants.dart';
import '../utils.dart';
import 'dialog_page.dart';
import 'primary_button.dart';

class BudgetCategoryEntryForm extends StatefulWidget {
  const BudgetCategoryEntryForm({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.colorScheme,
  });

  final String? title;
  final String? description;
  final BudgetCategoryIcon? icon;
  final BudgetCategoryColorScheme? colorScheme;

  @override
  State<BudgetCategoryEntryForm> createState() => _BudgetCategoryEntryFormState();
}

class _BudgetCategoryEntryFormState extends State<BudgetCategoryEntryForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController = TextEditingController(text: widget.title ?? '');
  late final TextEditingController _descriptionController = TextEditingController(text: widget.description ?? '');
  late BudgetCategoryIcon _icon = widget.icon ?? BudgetCategoryIcon.values.random();
  late BudgetCategoryColorScheme _colorScheme = widget.colorScheme ?? BudgetCategoryColorScheme.values.random();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    const SizedBox spacing = SizedBox(height: 12.0);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0).withKeyboardPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            spacing,
            TextFormField(
              controller: _titleController,
              maxLength: kTitleMaxCharacterLength,
              decoration: InputDecoration(hintText: l10n.titleLabel),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: (String? value) =>
                  value != null && value.length < 3 ? l10n.atLeastNCharactersErrorMessage(3) : null,
            ),
            spacing,
            TextFormField(
              controller: _descriptionController,
              maxLines: 2,
              maxLength: kDescriptionMaxCharacterLength,
              decoration: InputDecoration(hintText: l10n.descriptionLabel),
              textCapitalization: TextCapitalization.sentences,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
            spacing,
            Wrap(
              runSpacing: 8,
              spacing: 8,
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (BudgetCategoryColorScheme colorScheme in BudgetCategoryColorScheme.values)
                  _ColorItem(
                    key: ObjectKey(colorScheme),
                    icon: _icon,
                    colorScheme: colorScheme,
                    selected: colorScheme == _colorScheme,
                    onPressed: () => _handleIconSelection(colorScheme),
                  ),
              ],
            ),
            spacing,
            TextButton(
              onPressed: _handleCategorySelection,
              child: Text(l10n.selectIconCaption),
            ),
            spacing,
            PrimaryButton(
              onPressed: _handleSubmit,
              caption: l10n.submitCaption,
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
        BudgetCategoryEntryResult(
          title: _titleController.text,
          description: _descriptionController.text,
          icon: _icon,
          colorScheme: _colorScheme,
        ),
      );
    }
  }

  void _handleIconSelection(BudgetCategoryColorScheme colorScheme) {
    setState(() => _colorScheme = colorScheme);
  }

  void _handleCategorySelection() async {
    final BudgetCategoryIcon? icon = await showModalBottomSheet(
      context: context,
      builder: (_) => _IconPicker(initialValue: _icon),
    );
    if (icon != null) {
      setState(() => _icon = icon);
    }
  }
}

Future<BudgetCategoryEntryResult?> showBudgetCategoryEntryForm({
  required BuildContext context,
  required String? title,
  required String? description,
  required BudgetCategoryIcon? icon,
  required BudgetCategoryColorScheme? colorScheme,
}) =>
    showDialogPage(
      context: context,
      builder: (_) => BudgetCategoryEntryForm(
        title: title,
        description: description,
        icon: icon,
        colorScheme: colorScheme,
      ),
    );

class BudgetCategoryEntryResult {
  const BudgetCategoryEntryResult({
    required this.title,
    required this.description,
    required this.icon,
    required this.colorScheme,
  });

  final String title;
  final String description;
  final BudgetCategoryIcon icon;
  final BudgetCategoryColorScheme colorScheme;
}

class _IconPicker extends StatelessWidget {
  const _IconPicker({required this.initialValue});

  final BudgetCategoryIcon initialValue;

  static const double _dimension = 48.0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Wrap(
          runSpacing: 8,
          spacing: 8,
          alignment: WrapAlignment.center,
          children: <Widget>[
            for (final BudgetCategoryIcon icon in BudgetCategoryIcon.values)
              InkWell(
                key: ObjectKey(icon),
                onTap: icon == initialValue ? null : () => Navigator.pop(context, icon),
                child: Ink(
                  height: _dimension,
                  width: _dimension,
                  child: Icon(
                    icon.data,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    super.key,
    required this.colorScheme,
    required this.icon,
    required this.onPressed,
    required this.selected,
  });

  final BudgetCategoryColorScheme colorScheme;
  final BudgetCategoryIcon icon;
  final VoidCallback onPressed;
  final bool selected;

  static const double _dimension = 56.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selected ? null : onPressed,
      child: Ink(
        height: _dimension,
        width: _dimension,
        decoration: BoxDecoration(
          color: colorScheme.background,
          border: selected ? Border.all(color: colorScheme.foreground, width: 4) : null,
          borderRadius: BorderRadius.circular(selected ? _dimension / 2 : 8),
        ),
        child: Icon(icon.data, color: colorScheme.foreground),
      ),
    );
  }
}
