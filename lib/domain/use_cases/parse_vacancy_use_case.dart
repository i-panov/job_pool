import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/parse.dart';
import 'package:job_pool/data/dto/company_save_args.dart';
import 'package:job_pool/data/dto/vacancy_save_args.dart';
import 'package:job_pool/domain/repositories/companies_repository.dart';
import 'package:job_pool/domain/repositories/vacancies_repository.dart';

class ParseVacancyUseCase {
  final CompaniesRepository companiesRepository;
  final VacanciesRepository vacanciesRepository;

  const ParseVacancyUseCase({
    required this.companiesRepository,
    required this.vacanciesRepository,
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
      final vacancyId = await vacanciesRepository.insert(
        VacancySaveArgs(
          companyId: companyId,
          link: parsed.vacancyLink,
          grades: parsed.grades,
        ),
      );

      // TODO: save parsed.directions

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
