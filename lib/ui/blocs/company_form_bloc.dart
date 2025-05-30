import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_pool/data/storage/db/db.dart';

class CompanyFormBloc extends Bloc<CompanyFormEvent, CompanyFormState> {
  final int? companyId;
  final AppDatabase db;

  CompanyFormBloc({this.companyId, required this.db})
    : super(const CompanyFormStateInitial()) {
    on<CompanyFormEventLoadingCompany>((event, emit) async {
      if (companyId == null) {
        emit(const CompanyFormStateLoaded());
        return;
      }

      final company = await db.getCompany(companyId!);

      if (company == null) {
        final msg = 'Компания #$companyId не найдена';
        emit(CompanyFormStateCompanyLoadingFailure(message: msg));
        return;
      }

      emit(CompanyFormStateLoaded(name: company.name));
    });

    on<CompanyFormEventNameChanged>((event, emit) async {
      emit((state as CompanyFormStateLoaded).copyWith(name: event.name));
    });

    on<CompanyFormEventITChanged>((event, emit) async {
      emit((state as CompanyFormStateLoaded).copyWith(isIT: event.isIT));
    });

    on<CompanyFormEventLinkChanged>((event, emit) async {
      final currentState = state as CompanyFormStateLoaded;

      emit(
        currentState.copyWith(
          links: currentState.links.replace(event.linkIndex, event.linkValue),
        ),
      );
    });

    on<CompanyFormEventLinkMoved>((event, emit) async {
      print(event);

      if (event.fromIndex == event.toIndex) {
        return;
      }

      final currentState = state as CompanyFormStateLoaded;
      final value = currentState.links[event.fromIndex];

      final newLinks = currentState.links
          .insert(event.toIndex, value)
          .removeAt(
            event.fromIndex < event.toIndex
                ? event.fromIndex
                : event.fromIndex + 1,
          );

      print(currentState.links);
      print(newLinks);
      emit(currentState.copyWith(links: newLinks));
    });

    on<CompanyFormEventLinkAdded>((event, emit) async {
      final currentState = state as CompanyFormStateLoaded;

      emit(currentState.copyWith(links: currentState.links.add('')));
    });

    on<CompanyFormEventLinkRemoved>((event, emit) async {
      final currentState = state as CompanyFormStateLoaded;

      emit(
        currentState.copyWith(links: currentState.links.removeAt(event.index)),
      );
    });

    on<CompanyFormEventSubmitted>((event, emit) async {
      final currentState = state as CompanyFormStateLoaded;

      if (currentState.name.isEmpty) {
        emit(
          const CompanyFormStateInvalidOperation(
            message: 'Введите название компании',
          ),
        );

        emit(currentState);
        return;
      }
    });

    add(CompanyFormEventLoadingCompany());
  }

  void changeName(String value) => add(CompanyFormEventNameChanged(value));

  void changeIsIT(bool value) => add(CompanyFormEventITChanged(isIT: value));

  void changeLink(int index, String value) =>
      add(CompanyFormEventLinkChanged(linkIndex: index, linkValue: value));

  void moveLink(int fromIndex, int toIndex) =>
      add(CompanyFormEventLinkMoved(fromIndex: fromIndex, toIndex: toIndex));

  void addLink() => add(CompanyFormEventLinkAdded());

  void removeLink(int index) => add(CompanyFormEventLinkRemoved(index: index));
}

//------------------------

sealed class CompanyFormEvent {
  const CompanyFormEvent();
}

class CompanyFormEventLoadingCompany extends CompanyFormEvent {
  const CompanyFormEventLoadingCompany();
}

class CompanyFormEventNameChanged extends CompanyFormEvent {
  final String name;

  const CompanyFormEventNameChanged(this.name);
}

class CompanyFormEventITChanged extends CompanyFormEvent {
  final bool isIT;

  const CompanyFormEventITChanged({required this.isIT});
}

class CompanyFormEventLinkChanged extends CompanyFormEvent {
  final String linkValue;
  final int linkIndex;

  const CompanyFormEventLinkChanged({
    required this.linkValue,
    required this.linkIndex,
  });
}

class CompanyFormEventLinkMoved extends CompanyFormEvent {
  final int fromIndex;
  final int toIndex;

  const CompanyFormEventLinkMoved({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  String toString() => "$runtimeType($fromIndex, $toIndex)";
}

class CompanyFormEventLinkAdded extends CompanyFormEvent {
  const CompanyFormEventLinkAdded();
}

class CompanyFormEventLinkRemoved extends CompanyFormEvent {
  final int index;

  const CompanyFormEventLinkRemoved({required this.index});
}

class CompanyFormEventSubmitted extends CompanyFormEvent {
  const CompanyFormEventSubmitted();
}

//------------------------

sealed class CompanyFormState extends Equatable {
  const CompanyFormState();

  @override
  List<Object?> get props => [];
}

class CompanyFormStateInitial extends CompanyFormState {
  const CompanyFormStateInitial();
}

class CompanyFormStateLoaded extends CompanyFormState {
  final String name;
  final bool isIT;
  final IList<String> links;

  const CompanyFormStateLoaded({
    this.name = '',
    this.isIT = false,
    this.links = const IList.empty(),
  });

  CompanyFormStateLoaded copyWith({
    String? name,
    bool? isIT,
    IList<String>? links,
  }) => CompanyFormStateLoaded(
    name: name ?? this.name,
    isIT: isIT ?? this.isIT,
    links: links ?? this.links,
  );

  @override
  List<Object?> get props => [name, isIT, links];
}

class CompanyFormStateCompanyLoadingFailure extends CompanyFormState {
  final String message;

  const CompanyFormStateCompanyLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CompanyFormStateInvalidOperation extends CompanyFormState {
  final String message;

  const CompanyFormStateInvalidOperation({required this.message});

  @override
  List<Object?> get props => [message];
}
