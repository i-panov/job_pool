import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/data/repositories/companies_repository_impl.dart';
import 'package:job_pool/data/repositories/story_items_repository_impl.dart';
import 'package:job_pool/data/repositories/vacancies_repository_impl.dart';
import 'package:job_pool/domain/repositories/companies_repository.dart';
import 'package:job_pool/domain/repositories/story_items_repository.dart';
import 'package:job_pool/domain/repositories/vacancies_repository.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final companiesRepository = Provider<CompaniesRepository>((ref) {
  return CompaniesRepositoryImpl(ref.read(dbProvider));
});

final vacanciesRepository = Provider<VacanciesRepository>((ref) {
  return VacanciesRepositoryImpl(ref.read(dbProvider));
});

final storyItemsRepository = Provider<StoryItemsRepository>((ref) {
  return StoryItemsRepositoryImpl(ref.read(dbProvider));
});
