import 'dart:ui';

class BudgetCategoryColorScheme {
  const BudgetCategoryColorScheme._(this.foreground, this.background, this.brightness);

  static const BudgetCategoryColorScheme excess = BudgetCategoryColorScheme._(
    Color(0xFFB7B7B7),
    Color(0xFF363636),
    Brightness.dark,
  );

  final Color foreground;
  final Color background;
  final Brightness brightness;

  int get index => values.indexOf(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetCategoryColorScheme &&
          runtimeType == other.runtimeType &&
          foreground == other.foreground &&
          background == other.background &&
          brightness == other.brightness;

  @override
  int get hashCode => foreground.hashCode ^ background.hashCode ^ brightness.hashCode;

  static const List<BudgetCategoryColorScheme> values = <BudgetCategoryColorScheme>[
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFF00539C), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFEEA47F), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFF2F3C7E), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFFBEAEB), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFFF96167), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFFCE77D), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFCCF381), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFF317773), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFF8AAAE5), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFFFF69B4), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFF00FFFF), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFFCEDDA), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFFEE4E34), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFADD8E6), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFF111111), Color(0x89ABE3FF), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xEA738DFF), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFC5FAD5), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFF2C5F2D), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFCF6F5FF), Brightness.light),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFFE77AFF), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFFFFFFFF), Color(0xFF234E70), Brightness.dark),
    BudgetCategoryColorScheme._(Color(0xFF000000), Color(0xFFFBF8BE), Brightness.light),
  ];
}
