import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class CompanySaveArgs {
  final int id;
  final String name;
  final String comment;
  final bool isIT;
  final ISet<String> links;

  const CompanySaveArgs({
    this.id = -1,
    required this.name,
    this.comment = '',
    this.isIT = false,
    this.links = const ISet.empty(),
  });

  bool get isNew => id < 0;
}
