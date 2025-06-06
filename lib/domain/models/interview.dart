import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';

class Interview extends Equatable {
  final DateTime time;
  final bool isOnline;
  final String target;
  final InterviewType type;

  final int vacancyId;
  
  final String companyName;
  final ISet<String> jobDirections;
  final ISet<JobGrade> jobGrades;

  const Interview({
    required this.vacancyId,
    required this.time,
    required this.isOnline,
    required this.target,
    required this.companyName,
    required this.type,
    required this.jobDirections,
    required this.jobGrades,
  });

  @override
  List<Object?> get props => [
    vacancyId,
    time,
    isOnline,
    target,
    companyName,
    type,
    jobDirections,
    jobGrades,
  ];
}
