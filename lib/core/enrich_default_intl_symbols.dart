import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

const _us = 'en_US';
const _nigeria = 'en_NG';
const _nigeriaCurrencyCode = 'NGN';

final _Symbols _enUs = (numberFormatSymbols[_us]!, compactNumberSymbols[_us]!);

/// This is a hack because the dart team chooses to filter out certain locales for fear of potential duplicates.
/// https://github.com/dart-lang/i18n/issues/160#issuecomment-1513218136
void enrichDefaultIntlSymbols() {
  final symbols =
      <String, String>{
        'en_DE': 'de',
        'en_NL': 'nl',
      }.map(
        (String key, String value) => MapEntry<String, _Symbols>(
          key,
          (numberFormatSymbols[value]!, compactNumberSymbols[value]!),
        ),
      );
  symbols[_nigeria] = (_enUs.$1.copyWith(name: _nigeria, defCurrencyCode: _nigeriaCurrencyCode), _enUs.$2);
  symbols.forEach((String key, _Symbols symbols) {
    numberFormatSymbols.putIfAbsent(key, () => symbols.$1);
    compactNumberSymbols.putIfAbsent(key, () => symbols.$2);
  });
}

typedef _Symbols = (NumberSymbols, CompactNumberSymbols);

extension on NumberSymbols {
  NumberSymbols copyWith({
    String? name,
    String? decimalSep,
    String? groupSep,
    String? percent,
    String? zeroDigit,
    String? plusSign,
    String? minusSign,
    String? expSymbol,
    String? permill,
    String? infinity,
    String? nan,
    String? decimalPattern,
    String? scientificPattern,
    String? percentPattern,
    String? currencyPattern,
    String? defCurrencyCode,
  }) => NumberSymbols(
    NAME: name ?? NAME,
    DECIMAL_SEP: decimalSep ?? DECIMAL_SEP,
    GROUP_SEP: groupSep ?? GROUP_SEP,
    PERCENT: percent ?? PERCENT,
    ZERO_DIGIT: zeroDigit ?? ZERO_DIGIT,
    PLUS_SIGN: plusSign ?? PLUS_SIGN,
    MINUS_SIGN: minusSign ?? MINUS_SIGN,
    EXP_SYMBOL: expSymbol ?? EXP_SYMBOL,
    PERMILL: permill ?? PERMILL,
    INFINITY: infinity ?? INFINITY,
    NAN: nan ?? NAN,
    DECIMAL_PATTERN: decimalPattern ?? DECIMAL_PATTERN,
    SCIENTIFIC_PATTERN: scientificPattern ?? SCIENTIFIC_PATTERN,
    PERCENT_PATTERN: percentPattern ?? PERCENT_PATTERN,
    CURRENCY_PATTERN: currencyPattern ?? CURRENCY_PATTERN,
    DEF_CURRENCY_CODE: defCurrencyCode ?? DEF_CURRENCY_CODE,
  );
}
