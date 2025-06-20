import 'package:drift/drift.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/domain/repositories/job_directions_repository.dart';

class JobDirectionsRepositoryImpl implements JobDirectionsRepository {
  final AppDatabase _db;

  const JobDirectionsRepositoryImpl(this._db);

  @override
  Future<List<JobDirectionDto>> getAll() => _db.select(_db.jobDirections).get();

  @override
  Future<List<JobDirectionDto>> filter(Set<String> names) {
    final query = _db.select(_db.jobDirections)
      ..where((f) => f.name.isIn(names));

    return query.get();
  }

  @override
  Future<int> insert(String name) {
    final jobDirection = JobDirectionsCompanion.insert(name: name);
    return _db.into(_db.jobDirections).insert(jobDirection);
  }

  @override
  Future<void> inertMany(Set<String> names) {
    return _db.batch((batch) {
      batch.insertAll(_db.jobDirections, [
        for (final name in names)
          JobDirectionsCompanion.insert(name: name),
      ]);
    });
  }

  @override
  Future<bool> update(int id, String name) {
    return _db
        .update(_db.jobDirections)
        .replace(JobDirectionsCompanion(id: Value(id), name: Value(name)));
  }

  @override
  Future<void> remove(int id) {
    return (_db.delete(_db.jobDirections)..where((f) => f.id.equals(id))).go();
  }
}
