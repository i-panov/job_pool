import 'package:job_pool/data/db/db.dart';

abstract interface class JobDirectionsRepository {
  Future<List<JobDirectionDto>> getAll();
}
