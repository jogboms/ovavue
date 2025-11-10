// dart format off
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Ovavue'**
  String get appName;

  /// No description provided for @crashViewTitleMessage.
  ///
  /// In en, this message translates to:
  /// **'Oh :('**
  String get crashViewTitleMessage;

  /// No description provided for @crashViewQuoteMessage.
  ///
  /// In en, this message translates to:
  /// **'\"Houston, we have a problem\"'**
  String get crashViewQuoteMessage;

  /// No description provided for @crashViewQuoteAuthor.
  ///
  /// In en, this message translates to:
  /// **'R & D'**
  String get crashViewQuoteAuthor;

  /// No description provided for @crashViewBugMessage1.
  ///
  /// In en, this message translates to:
  /// **'You just found a bug, no need to panic, we have logged the issue and would provide a resolution as soon as possible'**
  String get crashViewBugMessage1;

  /// No description provided for @crashViewBugMessage2.
  ///
  /// In en, this message translates to:
  /// **'If there\'s more to it, you could also file a personal complaint with our customer service representative'**
  String get crashViewBugMessage2;

  /// No description provided for @successfulMessage.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successfulMessage;

  /// No description provided for @genericErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Try again?'**
  String get genericErrorMessage;

  /// No description provided for @genericUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'The action is currently not available. Try at a later time.'**
  String get genericUnavailableMessage;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingMessage;

  /// No description provided for @tryAgainMessage.
  ///
  /// In en, this message translates to:
  /// **'Do try again after some time'**
  String get tryAgainMessage;

  /// No description provided for @letsCreateMessage.
  ///
  /// In en, this message translates to:
  /// **'Lets create your first budget plan'**
  String get letsCreateMessage;

  /// No description provided for @getStatedCaption.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStatedCaption;

  /// No description provided for @budgetsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get budgetsPageTitle;

  /// No description provided for @totalBudgetCaption.
  ///
  /// In en, this message translates to:
  /// **'Total budget'**
  String get totalBudgetCaption;

  /// No description provided for @deleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteLabel;

  /// No description provided for @excessLabel.
  ///
  /// In en, this message translates to:
  /// **'Excess Amount'**
  String get excessLabel;

  /// No description provided for @activeLabel.
  ///
  /// In en, this message translates to:
  /// **'active'**
  String get activeLabel;

  /// No description provided for @previousAllocationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Previous Allocations'**
  String get previousAllocationsTitle;

  /// No description provided for @associatedPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'Associated Plans'**
  String get associatedPlansTitle;

  /// No description provided for @plansPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get plansPageTitle;

  /// No description provided for @categoriesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesPageTitle;

  /// No description provided for @nonZeroAmountErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'You would need an amount higher than zero'**
  String get nonZeroAmountErrorMessage;

  /// No description provided for @notEnoughBudgetAmountErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'You do not have up to that amount left'**
  String get notEnoughBudgetAmountErrorMessage;

  /// No description provided for @atLeastNCharactersShortErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'At least {count} characters'**
  String atLeastNCharactersShortErrorMessage(int count);

  /// No description provided for @atLeastNCharactersErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This needs to be at least {count} characters'**
  String atLeastNCharactersErrorMessage(int count);

  /// No description provided for @createPlanCaption.
  ///
  /// In en, this message translates to:
  /// **'Create new budget plan'**
  String get createPlanCaption;

  /// No description provided for @selectPlanCaption.
  ///
  /// In en, this message translates to:
  /// **'Select a plan'**
  String get selectPlanCaption;

  /// No description provided for @createCategoryCaption.
  ///
  /// In en, this message translates to:
  /// **'Create new budget category'**
  String get createCategoryCaption;

  /// No description provided for @selectCategoryCaption.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectCategoryCaption;

  /// No description provided for @selectBudgetTemplateCaption.
  ///
  /// In en, this message translates to:
  /// **'Select a budget template'**
  String get selectBudgetTemplateCaption;

  /// No description provided for @deletePlanAreYouSureAboutThisMessage.
  ///
  /// In en, this message translates to:
  /// **'This action is non-reversible and will also remove all allocations associated with this budget plan. Are you sure about this?'**
  String get deletePlanAreYouSureAboutThisMessage;

  /// No description provided for @deleteCategoryAreYouSureAboutThisMessage.
  ///
  /// In en, this message translates to:
  /// **'This action is non-reversible. Are you sure about this?'**
  String get deleteCategoryAreYouSureAboutThisMessage;

  /// No description provided for @deleteAllocationAreYouSureAboutThisMessage.
  ///
  /// In en, this message translates to:
  /// **'This action is non-reversible and would remove the allocation on the active budget for this budget plan. Are you sure about this?'**
  String get deleteAllocationAreYouSureAboutThisMessage;

  /// No description provided for @updatePlanCategoryAreYouSureAboutThisMessage.
  ///
  /// In en, this message translates to:
  /// **'This action is non-reversible and would update the category assigned this budget plan across all budgets. Are you sure about this?'**
  String get updatePlanCategoryAreYouSureAboutThisMessage;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @valueLabel.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get valueLabel;

  /// No description provided for @startDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Starting date'**
  String get startDateLabel;

  /// No description provided for @endDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Ending date?'**
  String get endDateLabel;

  /// No description provided for @makeActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Make this active?'**
  String get makeActiveLabel;

  /// No description provided for @submitCaption.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitCaption;

  /// No description provided for @selectIconCaption.
  ///
  /// In en, this message translates to:
  /// **'Select icon'**
  String get selectIconCaption;

  /// No description provided for @emptyContentMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing to see here :)'**
  String get emptyContentMessage;

  /// No description provided for @amountRemainingCaption.
  ///
  /// In en, this message translates to:
  /// **'{amount} left'**
  String amountRemainingCaption(String amount);

  /// No description provided for @preferencesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferencesPageTitle;

  /// No description provided for @backupClientProviderLabel.
  ///
  /// In en, this message translates to:
  /// **'DATABASE BACKUP PROVIDER'**
  String get backupClientProviderLabel;

  /// No description provided for @backupClientImportLabel.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get backupClientImportLabel;

  /// No description provided for @backupClientExportLabel.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get backupClientExportLabel;

  /// No description provided for @copiedToClipboardMessage.
  ///
  /// In en, this message translates to:
  /// **'Copied to the clipboard'**
  String get copiedToClipboardMessage;

  /// No description provided for @exitAppMessage.
  ///
  /// In en, this message translates to:
  /// **'You would need to restart Ovavue to continue'**
  String get exitAppMessage;

  /// No description provided for @continueCaption.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueCaption;

  /// No description provided for @accountKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT KEY'**
  String get accountKeyLabel;

  /// No description provided for @metadataPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Metadata'**
  String get metadataPageTitle;

  /// No description provided for @modifyCaption.
  ///
  /// In en, this message translates to:
  /// **'Modify metadata'**
  String get modifyCaption;

  /// No description provided for @createNewMetadataValueType.
  ///
  /// In en, this message translates to:
  /// **'Add metadata value'**
  String get createNewMetadataValueType;

  /// No description provided for @selectMetadataCaption.
  ///
  /// In en, this message translates to:
  /// **'Select metadata'**
  String get selectMetadataCaption;

  /// No description provided for @selectMetadataValueCaption.
  ///
  /// In en, this message translates to:
  /// **'Select value'**
  String get selectMetadataValueCaption;

  /// No description provided for @aggregateAllocationCaption.
  ///
  /// In en, this message translates to:
  /// **'Aggregate allocation'**
  String get aggregateAllocationCaption;

  /// No description provided for @getInTouchLabel.
  ///
  /// In en, this message translates to:
  /// **'GET IN TOUCH'**
  String get getInTouchLabel;

  /// No description provided for @themeModeLabel.
  ///
  /// In en, this message translates to:
  /// **'THEME'**
  String get themeModeLabel;

  /// No description provided for @featureRequestsLabel.
  ///
  /// In en, this message translates to:
  /// **'FEATURE REQUESTS'**
  String get featureRequestsLabel;

  /// No description provided for @translationFeatureRequestCaption.
  ///
  /// In en, this message translates to:
  /// **'New Translation'**
  String get translationFeatureRequestCaption;

  /// No description provided for @currencyFeatureRequestCaption.
  ///
  /// In en, this message translates to:
  /// **'New Currency'**
  String get currencyFeatureRequestCaption;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return L10nEn();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
