import 'package:equatable/equatable.dart';
import 'package:job_pool/core/enums.dart';

class Contact extends Equatable {
  final ContactType type;
  final String value;

  const Contact({this.type = ContactType.phone, this.value = ''});

  @override
  List<Object?> get props => [type, value];
}
