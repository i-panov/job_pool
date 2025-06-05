import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';

class Vacancy extends Equatable {
  final int id;
  final String link, comment;
  final ISet<JobGrades> grades;
  final IMap<int, String> directions;
  final IMap<ContactTypes, String> contacts;
  final int companyId;
  final String companyName;

  const Vacancy({
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
