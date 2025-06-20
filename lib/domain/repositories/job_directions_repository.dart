import 'package:job_pool/data/db/db.dart';

abstract interface class JobDirectionsRepository {
  Future<List<JobDirectionDto>> getAll();
  Future<int> insert(String name);
  Future<void> inertMany(Set<String> names);
  Future<bool> update(int id, String name);
  Future<void> remove(int id);
  Future<List<JobDirectionDto>> filter(Set<String> names);
}
