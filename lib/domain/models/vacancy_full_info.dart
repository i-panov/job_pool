import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/enums.dart';

class VacancyFullInfo extends Equatable {
  final int id;
  final String link, comment;
  final ISet<JobGrade> grades;
  final IList<({int id, String name})> directions;
  final IList<({ContactType type, String value})> contacts;
  final int companyId;
  final String companyName;

  const VacancyFullInfo({
    required this.id,
    required this.link,
    required this.comment,
    required this.grades,
    required this.directions,
    required this.contacts,
    required this.companyId,
    required this.companyName,
  });

  @override
  List<Object?> get props => [
    id,
    link,
    comment,
    grades,
    directions,
    contacts,
    companyId,
    companyName,
  ];
}
