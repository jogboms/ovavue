import 'package:equatable/equatable.dart';

class Money with EquatableMixin implements Comparable<Money> {
  const Money(this._value);

  static const Money zero = Money(0);

  final int _value;

  // TODO(Jogboms): Implement actual solution.
  String get formatted => _value.toString();

  @override
  List<Object> get props => <Object>[_value];

  Money operator +(Money other) => Money(_value + other._value);

  Money operator -(Money other) => Money(_value - other._value);

  double operator /(Object other) {
    if (other is Money) {
      return _value / other._value;
    } else if (other is num) {
      return _value / other;
    }

    throw ArgumentError('invalid divisor type');
  }

  @override
  int compareTo(Money other) => _value.compareTo(other._value);

  double percentage(Money of) => (this / of * 100).roundToDouble();

  @override
  String toString() => formatted;
}

extension MoneyIntExtension on int {
  Money get asMoney => Money(this);
}
