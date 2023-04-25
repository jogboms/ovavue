import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Money with EquatableMixin implements Comparable<Money> {
  const Money(this.rawValue);

  static const double _divisor = 1e+6;

  static const Money zero = Money(0);

  static NumberFormat get _numberFormat => NumberFormat.simpleCurrency(decimalDigits: 2);

  static String get decimalSeparator => _numberFormat.symbols.DECIMAL_SEP;

  static RegExp regExp = RegExp('^\\d+$decimalSeparator?\\d{0,4}');

  static Money parse(String value) {
    if (value.isEmpty) {
      return Money.zero;
    }
    return Money((_numberFormat.parse(value) * _divisor).toInt());
  }

  final int rawValue;

  double get _editableValue => rawValue / _divisor;

  String get editableTextValue =>
      NumberFormat.decimalPattern().format(_editableValue).replaceAll(_numberFormat.symbols.GROUP_SEP, '');

  String get formatted => _numberFormat.format(_editableValue);

  @override
  List<Object> get props => <Object>[rawValue];

  Money operator +(Money other) => Money(rawValue + other.rawValue);

  Money operator -(Money other) => Money(rawValue - other.rawValue);

  double operator /(Object other) {
    if (other is Money) {
      return rawValue / other.rawValue;
    } else if (other is num) {
      return rawValue / other;
    }

    throw ArgumentError('invalid divisor type');
  }

  bool operator >(Money other) => rawValue > other.rawValue;

  bool operator >=(Money other) => rawValue >= other.rawValue;

  bool operator <(Money other) => rawValue < other.rawValue;

  bool operator <=(Money other) => rawValue < other.rawValue;

  @override
  int compareTo(Money other) => rawValue.compareTo(other.rawValue);

  double ratio(Money of) => this / of;

  String percentage(Money of) => NumberFormat.decimalPercentPattern(decimalDigits: 1).format(ratio(of));

  @override
  String toString() => formatted;
}

extension MoneyIntExtension on int {
  Money get asMoney => Money(this);
}

extension MoneyIterableSumExtension on Iterable<Money> {
  Money sum() {
    if (isEmpty) {
      return Money.zero;
    }
    return reduce((Money value, Money current) => value + current);
  }
}
