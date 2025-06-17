import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/data/repositories/vacancies_repository_impl.dart';
import 'package:job_pool/domain/repositories/vacancies_repository.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final vacanciesRepository = Provider<VacanciesRepository>((ref) {
  return VacanciesRepositoryImpl(ref.read(dbProvider));
});
