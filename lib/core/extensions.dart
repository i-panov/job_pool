import 'package:fast_immutable_collections/fast_immutable_collections.dart';

extension AppIListExtension<T> on IList<T> {
  Iterable<R> zip<O, R>(Iterable<O> other, R Function(T, O) mapper) sync* {
    for (final (i, item) in other.indexed) {
      yield mapper(this[i], item);
    }
  }
}

extension AppListExtension<T> on List<T> {
  Iterable<R> zip<O, R>(Iterable<O> other, R Function(T, O) mapper) sync* {
    for (final (i, item) in other.indexed) {
      yield mapper(this[i], item);
    }
  }
}
