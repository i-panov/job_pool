import 'dart:convert';
import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:job_pool/models.dart';
import 'package:path_provider/path_provider.dart';

class CompaniesManager extends ValueNotifier<IList<Company>> {
  final File file;

  CompaniesManager(this.file) : super(const IList.empty()) {
    load();
  }

  static Future<CompaniesManager> create() async {
    final file = File(
      '${(await getApplicationDocumentsDirectory()).path}/companies.json',
    );

    if (!(await file.exists())) {
      file.createSync(recursive: true);
    }

    return CompaniesManager(file);
  }

  Future<void> load() async {
    final json = jsonDecode(await file.readAsString());
    final items = IList<Company>(json.map((e) => Company.fromJson(e)));
    value = items.add(Company.defaultCompany);
  }

  Future<void> save() async {
    await file.writeAsString(jsonEncode(value.map((e) => e.toJson())));
  }

  Set<String> get vacancyDirections {
    final result = <String>{};

    for (final company in value) {
      for (final vacancy in company.vacancies) {
        result.addAll(vacancy.directions);
      }
    }

    return result;
  }
}
