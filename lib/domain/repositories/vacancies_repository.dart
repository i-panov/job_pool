import 'package:drift/drift.dart';
import 'package:job_pool/data/dto/vacancy_save_args.dart';
import 'package:job_pool/domain/models/vacancy_full_info.dart';
import 'package:job_pool/domain/models/vacancy_short_info.dart';

abstract interface class VacanciesRepository {
  Future<int> insert(VacancySaveArgs args);
  Future<void> update(VacancySaveArgs args);
  Future<void> remove(int id);
  Selectable<VacancyFullInfo> select(int id);
  Selectable<VacancyShortInfo> filterByCompany(int companyId);
  Future<int?> findByCompanyAndLink(int companyId, String link);
}
