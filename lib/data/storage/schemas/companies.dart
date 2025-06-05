import 'package:drift/drift.dart';
import 'package:job_pool/data/storage/types.dart';

@DataClassName('CompanyDto')
class Companies extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
  late final isIT = boolean().named('is_it')();
  late final comment = text().withDefault(Constant(''))();
  late final links = customType(const StringSetType())();
}
