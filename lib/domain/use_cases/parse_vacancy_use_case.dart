import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/parse.dart';
import 'package:job_pool/data/dto/company_save_args.dart';
import 'package:job_pool/data/dto/vacancy_save_args.dart';
import 'package:job_pool/domain/repositories/companies_repository.dart';
import 'package:job_pool/domain/repositories/job_directions_repository.dart';
import 'package:job_pool/domain/repositories/vacancies_repository.dart';

class ParseVacancyUseCase {
  final CompaniesRepository companiesRepository;
  final VacanciesRepository vacanciesRepository;
  final JobDirectionsRepository jobDirectionsRepository;

  const ParseVacancyUseCase({
    required this.companiesRepository,
    required this.vacanciesRepository,
    required this.jobDirectionsRepository,
  });

  Future<int> call(Uri uri) async {
    final parsed = await parseHeadHunterVacancy(uri);
    final company = await companiesRepository.findByName(parsed.companyName);
    final companyId = company?.id ?? await _insertCompany(parsed);

    final vacancyId = await vacanciesRepository.findByCompanyAndLink(
      companyId,
      parsed.vacancyLink,
    );

    if (vacancyId == null) {
      final presentDirections = await jobDirectionsRepository.filter(
        parsed.directions.unlock,
      );

      final presentDirectionsMap = {
        for (final d in presentDirections) d.name: d.id,
      };

      final absentDirectionsNames = {
        for (final d in parsed.directions)
          if (!presentDirectionsMap.containsKey(d)) d,
      };

      await jobDirectionsRepository.inertMany(absentDirectionsNames);

      final insertedDirections = await jobDirectionsRepository.filter(
        absentDirectionsNames,
      );

      final directionIds = [
        ...presentDirectionsMap.values,
        ...insertedDirections.map((d) => d.id),
      ];

      final vacancyId = await vacanciesRepository.insert(
        VacancySaveArgs(
          companyId: companyId,
          link: parsed.vacancyLink,
          grades: parsed.grades,
          directionIds: directionIds.toISet(),
        ),
      );

      return vacancyId;
    }

    return vacancyId;
  }

  Future<int> _insertCompany(HeadHunterParsedVacancy parsed) {
    return companiesRepository.insert(
      CompanySaveArgs(
        name: parsed.companyName,
        isIT: parsed.isIt,
        links: ISet([parsed.companyLink]),
      ),
    );
  }
}
