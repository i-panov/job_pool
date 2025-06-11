import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class Task extends Equatable {
  final String link, companyName;
  final DateTime deadline, createdAt;
  final IList<String> directions;
  final int vacancyId;

  const Task({
    required this.link,
    required this.companyName,
    required this.deadline,
    required this.createdAt,
    required this.directions,
    required this.vacancyId,
  });

  @override
  List<Object?> get props => [
    link,
    companyName,
    deadline,
    createdAt,
    directions,
    vacancyId,
  ];
}
