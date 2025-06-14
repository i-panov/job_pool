import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class StringSetType implements CustomSqlType<ISet<String>> {
  static const instance = StringSetType();

  /// максимально уникальный разделитель, чтобы не конфликтовало с содержимым
  static const _separator = '||--###--||';

  final String separator;

  const StringSetType({this.separator = _separator});

  @override
  String mapToSqlLiteral(ISet<String> dartValue) {
    final str = dartValue.join(_separator);
    return "'$str'";
  }

  @override
  Object mapToSqlParameter(ISet<String> dartValue) {
    return dartValue.join(_separator);
  }

  @override
  ISet<String> read(Object fromSql) {
    if (fromSql is! String || fromSql.isEmpty) {
      return const ISet.empty();
    }

    return fromSql.split(_separator).toISet();
  }

  @override
  String sqlTypeName(GenerationContext context) => 'TEXT';
}

class EnumSetType<T extends Enum> implements CustomSqlType<ISet<T>> {
  final List<T> _values;

  const EnumSetType(this._values);

  @override
  String mapToSqlLiteral(ISet<T> dartValue) {
    return StringSetType.instance.mapToSqlLiteral(
      dartValue.map((e) => e.name).toISet(),
    );
  }

  @override
  Object mapToSqlParameter(ISet<T> dartValue) {
    return StringSetType.instance.mapToSqlParameter(
      dartValue.map((e) => e.name).toISet(),
    );
  }

  @override
  ISet<T> read(Object fromSql) {
    return StringSetType.instance
        .read(fromSql)
        .map((e) {
          try {
            return _values.byName(e);
          } catch (_) {
            return null;
          }
        })
        .whereType<T>()
        .toISet();
  }

  @override
  String sqlTypeName(GenerationContext context) {
    return StringSetType.instance.sqlTypeName(context);
  }
}
