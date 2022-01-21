part of 'async_subject_bloc.dart';

class AsyncSubjectEvent extends Equatable {
  const AsyncSubjectEvent();

  @override
  List<Object> get props => [];
}

class LoadAsyncSubjectsEvent extends AsyncSubjectEvent {

  @override
  List<Object> get props => [];
}

class SearchInputChanged extends AsyncSubjectEvent{
  final String search;

  SearchInputChanged(this.search);

  @override
  List<Object> get props => [search];
}

class FiltersChanged extends AsyncSubjectEvent {
  final List<String> filteredSubjects;

  FiltersChanged(this.filteredSubjects);

  @override
  List<Object> get props => [filteredSubjects];
}