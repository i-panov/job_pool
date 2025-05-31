import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/data/storage/db/db.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
