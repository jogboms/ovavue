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
