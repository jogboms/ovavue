// dart format off

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Ovavue';

  @override
  String get crashViewTitleMessage => 'Oh :(';

  @override
  String get crashViewQuoteMessage => '\"Houston, we have a problem\"';

  @override
  String get crashViewQuoteAuthor => 'R & D';

  @override
  String get crashViewBugMessage1 => 'You just found a bug, no need to panic, we have logged the issue and would provide a resolution as soon as possible';

  @override
  String get crashViewBugMessage2 => 'If there\'s more to it, you could also file a personal complaint with our customer service representative';

  @override
  String get successfulMessage => 'Successful';

  @override
  String get genericErrorMessage => 'An error occurred. Try again?';

  @override
  String get genericUnavailableMessage => 'The action is currently not available. Try at a later time.';

  @override
  String get loadingMessage => 'Loading...';

  @override
  String get tryAgainMessage => 'Do try again after some time';

  @override
  String get letsCreateMessage => 'Lets create your first budget plan';

  @override
  String get getStatedCaption => 'Get started';

  @override
  String get budgetsPageTitle => 'Budgets';

  @override
  String get totalBudgetCaption => 'Total budget';

  @override
  String get deleteLabel => 'Delete';

  @override
  String get excessLabel => 'Excess Amount';

  @override
  String get activeLabel => 'active';

  @override
  String get previousAllocationsTitle => 'Previous Allocations';

  @override
  String get associatedPlansTitle => 'Associated Plans';

  @override
  String get plansPageTitle => 'Plans';

  @override
  String get categoriesPageTitle => 'Categories';

  @override
  String get nonZeroAmountErrorMessage => 'You would need an amount higher than zero';

  @override
  String get notEnoughBudgetAmountErrorMessage => 'You do not have up to that amount left';

  @override
  String atLeastNCharactersShortErrorMessage(int count) {
    return 'At least $count characters';
  }

  @override
  String atLeastNCharactersErrorMessage(int count) {
    return 'This needs to be at least $count characters';
  }

  @override
  String get createPlanCaption => 'Create new budget plan';

  @override
  String get selectPlanCaption => 'Select a plan';

  @override
  String get createCategoryCaption => 'Create new budget category';

  @override
  String get selectCategoryCaption => 'Select a category';

  @override
  String get selectBudgetTemplateCaption => 'Select a budget template';

  @override
  String get deletePlanAreYouSureAboutThisMessage => 'This action is non-reversible and will also remove all allocations associated with this budget plan. Are you sure about this?';

  @override
  String get deleteCategoryAreYouSureAboutThisMessage => 'This action is non-reversible. Are you sure about this?';

  @override
  String get deleteAllocationAreYouSureAboutThisMessage => 'This action is non-reversible and would remove the allocation on the active budget for this budget plan. Are you sure about this?';

  @override
  String get updatePlanCategoryAreYouSureAboutThisMessage => 'This action is non-reversible and would update the category assigned this budget plan across all budgets. Are you sure about this?';

  @override
  String get titleLabel => 'Title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get amountLabel => 'Amount';

  @override
  String get valueLabel => 'Value';

  @override
  String get startDateLabel => 'Starting date';

  @override
  String get endDateLabel => 'Ending date?';

  @override
  String get makeActiveLabel => 'Make this active?';

  @override
  String get submitCaption => 'Submit';

  @override
  String get selectIconCaption => 'Select icon';

  @override
  String get emptyContentMessage => 'Nothing to see here :)';

  @override
  String amountRemainingCaption(String amount) {
    return '$amount left';
  }

  @override
  String get preferencesPageTitle => 'Preferences';

  @override
  String get backupClientProviderLabel => 'DATABASE BACKUP PROVIDER';

  @override
  String get backupClientImportLabel => 'Import';

  @override
  String get backupClientExportLabel => 'Export';

  @override
  String get copiedToClipboardMessage => 'Copied to the clipboard';

  @override
  String get exitAppMessage => 'You would need to restart Ovavue to continue';

  @override
  String get continueCaption => 'Continue';

  @override
  String get accountKeyLabel => 'ACCOUNT KEY';

  @override
  String get metadataPageTitle => 'Metadata';

  @override
  String get modifyCaption => 'Modify metadata';

  @override
  String get createNewMetadataValueType => 'Add metadata value';

  @override
  String get selectMetadataCaption => 'Select metadata';

  @override
  String get selectMetadataValueCaption => 'Select value';

  @override
  String get aggregateAllocationCaption => 'Aggregate allocation';

  @override
  String get getInTouchLabel => 'GET IN TOUCH';

  @override
  String get themeModeLabel => 'THEME';

  @override
  String get featureRequestsLabel => 'FEATURE REQUESTS';

  @override
  String get translationFeatureRequestCaption => 'New Translation';

  @override
  String get currencyFeatureRequestCaption => 'New Currency';
}
