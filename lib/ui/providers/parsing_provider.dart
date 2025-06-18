import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/domain/use_cases/parse_vacancy_use_case.dart';
import 'package:job_pool/ui/providers/app_providers.dart';

class ParsingProvider extends Notifier<ParsingState> {
  late final _parse = ParseVacancyUseCase(
    companiesRepository: ref.read(companiesRepository),
    vacanciesRepository: ref.read(vacanciesRepository),
  );

  @override
  ParsingState build() => const ParsingInitial();

  Future<void> parse(String url) async {
    if (state is! ParsingInitial) {
      return;
    }

    state = const ParsingInProgress();

    try {
      final vacancyId = await _parse(url);
      state = ParsingSuccess(vacancyId);
    } catch (e) {
      state = ParsingFailure(e.toString());
    }

    state = const ParsingInitial();
  }
}

final parsingProvider = NotifierProvider<ParsingProvider, ParsingState>(
  ParsingProvider.new,
);

sealed class ParsingState extends Equatable {
  const ParsingState();
}

class ParsingInitial extends ParsingState {
  const ParsingInitial();

  @override
  List<Object?> get props => [];
}

class ParsingInProgress extends ParsingState {
  const ParsingInProgress();

  @override
  List<Object?> get props => [];
}

class ParsingSuccess extends ParsingState {
  final int vacancyId;

  const ParsingSuccess(this.vacancyId);

  @override
  List<Object?> get props => [vacancyId];
}

class ParsingFailure extends ParsingState {
  final String error;

  const ParsingFailure(this.error);

  @override
  List<Object?> get props => [error];
}
