import 'package:fast_immutable_collections/fast_immutable_collections.dart';

extension AppIListExtension<T> on IList<T> {
  Iterable<({T left, O right})> zip<O>(Iterable<O> other) sync* {
    for (final (i, item) in other.indexed) {
      yield (left: this[i], right: item);
    }
  }
}

extension AppListExtension<T> on List<T> {
  Iterable<({T left, O right})> zip<O>(Iterable<O> other) sync* {
    for (final (i, item) in other.indexed) {
      yield (left: this[i], right: item);
    }
  }
}
