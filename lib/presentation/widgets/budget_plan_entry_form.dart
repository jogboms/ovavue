import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../models.dart';
import '../state.dart';
import '../utils.dart';
import 'budget_category_avatar.dart';
import 'dialog_page.dart';
import 'primary_button.dart';

enum BudgetPlanEntryType { create, update }

class BudgetPlanEntryForm extends StatefulWidget {
  const BudgetPlanEntryForm({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.category,
  });

  final BudgetPlanEntryType type;
  final String? title;
  final String? description;
  final BudgetCategoryViewModel? category;

  @override
  State<BudgetPlanEntryForm> createState() => _BudgetPlanEntryFormState();
}

class _BudgetPlanEntryFormState extends State<BudgetPlanEntryForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _categoriesFieldKey = GlobalKey(debugLabel: 'categoriesFieldKey');
  static const Key _createCategoryButtonKey = Key('createCategoryButtonKey');

  late final TextEditingController _titleController = TextEditingController(text: widget.title ?? '');
  late final TextEditingController _descriptionController = TextEditingController(text: widget.description ?? '');
  late BudgetCategoryViewModel? _selectedCategory = widget.category;

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

    final bool creating = widget.type == BudgetPlanEntryType.create;
    final BudgetCategoryViewModel? initialCategory = widget.category;
    final BudgetCategoryViewModel? selectedCategory = _selectedCategory;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0).withKeyboardPadding(context),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final Iterable<BudgetCategoryViewModel> categories =
                ref.watch(budgetCategoriesProvider).valueOrNull ?? const <BudgetCategoryViewModel>[];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                spacing,
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
                  validator: (String? value) =>
                      value != null && value.length < 3 ? l10n.atLeastNCharactersErrorMessage(3) : null,
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
                if (initialCategory == null && creating) ...<Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      if (categories.isEmpty) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            key: _createCategoryButtonKey,
                            onPressed: () => _handleCategoryCreation(ref),
                            icon: const Icon(AppIcons.addCategory),
                            label: Text(context.l10n.createCategoryCaption),
                          ),
                        );
                      }

                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: categories.length == 1
                                ? Builder(
                                    builder: (_) {
                                      final BudgetCategoryViewModel category = categories.first;
                                      _handleCategorySelection(category);
                                      return _CategoryItem(key: Key(category.id), category: categories.first);
                                    },
                                  )
                                : DropdownButtonFormField<String>(
                                    key: _categoriesFieldKey,
                                    value: selectedCategory?.id,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      prefixIcon: selectedCategory?.id != null ? null : const Icon(AppIcons.categories),
                                      hintText: context.l10n.selectCategoryCaption,
                                    ),
                                    items: <DropdownMenuItem<String>>[
                                      for (final BudgetCategoryViewModel category in categories)
                                        DropdownMenuItem<String>(
                                          key: Key(category.id),
                                          value: category.id,
                                          child: _CategoryItem(category: category),
                                        ),
                                    ],
                                    onChanged: (String? id) => _handleCategoryIdSelection(categories, id),
                                  ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            key: _createCategoryButtonKey,
                            onPressed: () => _handleCategoryCreation(ref),
                            icon: const Icon(AppIcons.addCategory),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),
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

  void _handleCategoryCreation(WidgetRef ref) async {
    final String? id = await createBudgetCategoryAction(
      context: context,
      ref: ref,
      navigateOnComplete: false,
    );
    if (id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _categoriesFieldKey.currentState?.didChange(id);
      });
    }
  }

  void _handleCategorySelection(BudgetCategoryViewModel category) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedCategory = category;
    });
  }

  void _handleCategoryIdSelection(Iterable<BudgetCategoryViewModel> categories, String? id) {
    if (id != null) {
      _selectedCategory = categories.firstWhere((_) => _.id == id);
    }
  }

  void _handleSubmit() {
    final BudgetCategoryViewModel? category = _selectedCategory;
    if (category != null && _formKey.currentState?.validate() == true) {
      Navigator.pop(
        context,
        BudgetPlanEntryResult(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: category,
        ),
      );
    }
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({super.key, required this.category});

  final BudgetCategoryViewModel category;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: <Widget>[
        BudgetCategoryAvatar.small(
          colorScheme: category.colorScheme,
          icon: category.icon.data,
        ),
        const SizedBox(width: 8),
        Text(
          category.title.sentence(),
          maxLines: 1,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

Future<BudgetPlanEntryResult?> showBudgetPlanEntryForm({
  required BuildContext context,
  required BudgetPlanEntryType type,
  required String? title,
  required String? description,
  required BudgetCategoryViewModel? category,
}) =>
    showDialogPage(
      context: context,
      builder: (_) => BudgetPlanEntryForm(
        type: type,
        title: title,
        description: description,
        category: category,
      ),
    );

class BudgetPlanEntryResult {
  const BudgetPlanEntryResult({
    required this.title,
    required this.description,
    required this.category,
  });

  final String title;
  final String description;
  final BudgetCategoryViewModel category;
}
