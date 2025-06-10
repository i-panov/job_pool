import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';

class VacancyShortInfo extends Equatable {
  final int id;
  final IList<JobGrade> grades;
  final IList<String> directions;

  const VacancyShortInfo({
    required this.id,
    required this.grades,
    required this.directions,
  });

  @override
  List<Object?> get props => [id, grades, directions];
}
