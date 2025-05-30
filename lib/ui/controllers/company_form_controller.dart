import 'package:flutter/widgets.dart';
import 'package:job_pool/data/storage/db/db.dart';

class CompanyFormController extends ChangeNotifier {
  final int? companyId;
  final AppDatabase db;

  Company? company;

  CompanyFormController({this.companyId, required this.db}) {
    if (companyId != null) {
      db.getCompany(companyId!).then((value) {
        company = value;
        notifyListeners();
      });
    }
  }
}
