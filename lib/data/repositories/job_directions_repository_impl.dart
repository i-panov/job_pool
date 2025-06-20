import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/domain/repositories/job_directions_repository.dart';

class JobDirectionsRepositoryImpl implements JobDirectionsRepository {
  final AppDatabase _db;

  const JobDirectionsRepositoryImpl(this._db);

  @override
  Future<List<JobDirectionDto>> getAll() => _db.select(_db.jobDirections).get();
}
