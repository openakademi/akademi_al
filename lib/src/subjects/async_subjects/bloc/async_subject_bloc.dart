import 'dart:async';

import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/async_subject_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'async_subject_event.dart';

part 'async_subject_state.dart';

class AsyncSubjectBloc extends Bloc<AsyncSubjectEvent, AsyncSubjectState> {
  AsyncSubjectBloc(this._repository) : super(AsyncSubjectState());

  final AsyncSubjectRepository _repository;

  @override
  Stream<AsyncSubjectState> mapEventToState(
    AsyncSubjectEvent event,
  ) async* {
    if (event is LoadAsyncSubjectsEvent) {
      yield* _mapLoadAsyncSubjectsEventToState(event, state);
    } else if (event is SearchInputChanged) {
      yield _mapSearchInputChangedToState(event, state);
    } else if (event is FiltersChanged) {
      yield _mapFiltersChangedToState(event, state);
    }
  }

  Stream<AsyncSubjectState> _mapLoadAsyncSubjectsEventToState(
      LoadAsyncSubjectsEvent event, AsyncSubjectState state) async* {
    final asyncSubjects = await _repository.getWithAsync();
    final filteredAsyncSubject = asyncSubjects
        .where((element) =>
            element.gradeSubjects
                .expand((element) => element.classrooms)
                .toList()
                .length >
            0)
        .toList();
    filteredAsyncSubject.sort((a, b) => a.name.compareTo(b.name));
    yield state.copyWith(
        rawAsyncSubjects: asyncSubjects, asyncSubjects: filteredAsyncSubject, filteredSubjects: []);
  }

  AsyncSubjectState _mapSearchInputChangedToState(
      SearchInputChanged event, AsyncSubjectState state) {
    if (event.search.isNotEmpty) {
      final asyncSubjects = state.rawAsyncSubjects;
      final filteredAsyncSubject = asyncSubjects
          .where((element) =>
              element.gradeSubjects
                  .expand((element) => element.classrooms)
                  .toList()
                  .length >
              0)
          .toList();
      filteredAsyncSubject.sort((a, b) => a.name.compareTo(b.name));
      var filteredList = filteredAsyncSubject
          .where((element) =>
              element.name.toLowerCase().startsWith(event.search.toLowerCase()))
          .toList();
      if (state.filteredSubjects != null && state.filteredSubjects.isNotEmpty) {
        filteredList = filteredList
            .where((element) => state.filteredSubjects.contains(element.id))
            .toList();
      }

      return state.copyWith(asyncSubjects: filteredList);
    } else {
      final asyncSubjects = state.rawAsyncSubjects;
      var filteredList = asyncSubjects
          .where((element) =>
              element.gradeSubjects
                  .expand((element) => element.classrooms)
                  .toList()
                  .length >
              0)
          .toList();
      filteredList.sort((a, b) => a.name.compareTo(b.name));
      if (state.filteredSubjects != null && state.filteredSubjects.isNotEmpty) {
        filteredList = filteredList
            .where((element) => state.filteredSubjects.contains(element.id))
            .toList();
      }
      return state.copyWith(
          rawAsyncSubjects: asyncSubjects, asyncSubjects: filteredList);
    }
  }

  AsyncSubjectState _mapFiltersChangedToState(
      FiltersChanged event, AsyncSubjectState state) {
    final asyncSubjectsRaw = state.rawAsyncSubjects;
    final asyncSubjects = asyncSubjectsRaw
        .where((element) =>
            element.gradeSubjects
                .expand((element) => element.classrooms)
                .toList()
                .length >
            0)
        .toList();
    asyncSubjects.sort((a, b) => a.name.compareTo(b.name));
    List<AsyncSubject> filteredList;
    if (event.filteredSubjects != null && event.filteredSubjects.isNotEmpty) {
      filteredList = asyncSubjects
          .where((element) => event.filteredSubjects.contains(element.id))
          .toList();
    } else {
      filteredList = asyncSubjects;
    }

    return state.copyWith(
        asyncSubjects: filteredList, filteredSubjects: event.filteredSubjects);
  }
}
