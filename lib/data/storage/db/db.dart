import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/storage/mixins/company.dart';
import 'package:job_pool/data/storage/mixins/story.dart';
import 'package:job_pool/data/storage/mixins/vacancy.dart';
import 'package:job_pool/data/storage/schemas/companies.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/data/storage/schemas/vacancies.dart';
import 'package:job_pool/data/storage/types.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

typedef AppDatabaseBase = _$AppDatabase;

@DriftDatabase(
  tables: [
    Companies,
    Contacts,
    StoryItems,
    Vacancies,
    VacancyDirections,
    JobDirections,
  ],
  queries: {
    'selectVacancyFullInfoInternal':
        '''
    SELECT
      v.id, v.link, v.comment, v.grades,
      c.id AS company_id, c.name AS company_name,
      (
        SELECT GROUP_CONCAT(d.id, '${AppDatabase.separator}')
        FROM vacancy_directions vd
        JOIN job_directions d ON d.id = vd.direction
        WHERE vd.vacancy = v.id
        ORDER BY vd."order"
      ) AS direction_ids,
      (
        SELECT GROUP_CONCAT(d.name, '${AppDatabase.separator}')
        FROM vacancy_directions vd
        JOIN job_directions d ON d.id = vd.direction
        WHERE vd.vacancy = v.id
        ORDER BY vd."order"
      ) AS direction_names,
      (
        SELECT GROUP_CONCAT(ct.contact_type, '${AppDatabase.separator}')
        FROM contacts ct
        WHERE ct.vacancy = v.id
        ORDER BY ct.contact_type
      ) AS contact_types,
      (
        SELECT GROUP_CONCAT(ct.contact_value, '${AppDatabase.separator}')
        FROM contacts ct
        WHERE ct.vacancy = v.id
        ORDER BY ct.contact_type
      ) AS contact_values
    FROM vacancies v
    JOIN companies c ON c.id = v.company
    WHERE v.id = ?
  ''',
  },
)
class AppDatabase extends AppDatabaseBase
    with CompanyDbMixin, VacancyDbMixin, StoryDbMixin {
  static const separator = '#___SEPARATOR___#';

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'job_pool',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) {
      return m.createAll();
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        await managers.jobDirections.bulkCreate(
          (o) => [
            for (var direction in JobDirections.defaults) o(name: direction),
          ],
        );
      }
    },
  );
}
