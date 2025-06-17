import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/domain/models/contact.dart';

class VacancySaveArgs {
  final int id;
  final int companyId;
  final String link;
  final String comment;
  final ISet<JobGrade> grades;
  final ISet<int> directionIds;
  final IList<Contact> contacts;

  const VacancySaveArgs({
    this.id = -1,
    required this.companyId,
    required this.link,
    this.comment = '',
    this.grades = const ISet.empty(),
    this.directionIds = const ISet.empty(),
    this.contacts = const IList.empty(),
  });

  bool get isNew => id < 0;
}
