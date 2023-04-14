import 'dart:math';

extension FoldToMapExtension<T> on Iterable<T> {
  Map<String, T> foldToMap(String Function(T) keyBuilder) => fold(
        <String, T>{},
        (Map<String, T> previousValue, T element) => <String, T>{...previousValue, keyBuilder(element): element},
      );
}

extension UniqueByExtension<E> on Iterable<E> {
  Iterable<E> uniqueBy<U>(U Function(E) keyOf) => fold(
        <U, E>{},
        (Map<U, E> previousValue, E element) => previousValue..putIfAbsent(keyOf(element), () => element),
      ).values;
}

extension RandomEnum<T extends Object> on Iterable<T> {
  T random() {
    if (isEmpty) {
      throw StateError('No element');
    }
    if (length == 1) {
      return elementAt(0);
    }
    return elementAt(Random().nextInt(length));
  }
}
