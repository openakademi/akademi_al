part of 'async_subject_bloc.dart';

class AsyncSubjectState extends Equatable {
  const AsyncSubjectState(
      {this.filters, this.filteredSubjects, this.rawAsyncSubjects, this.asyncSubjects});

  final List<AsyncSubject> asyncSubjects;
  final List<AsyncSubject> rawAsyncSubjects;
  final List<String> filteredSubjects;
  final List<AsyncSubject> filters;

  AsyncSubjectState copyWith({
    List<AsyncSubject> asyncSubjects,
    List<AsyncSubject> rawAsyncSubjects,
    List<String> filteredSubjects
  }) {
    List<AsyncSubject> filteredAsyncSubject;
    if(rawAsyncSubjects != null && rawAsyncSubjects.isNotEmpty) {
      final filters = rawAsyncSubjects;
      filteredAsyncSubject = filters
          .where((element) =>
      element.gradeSubjects
          .expand((element) => element.classrooms)
          .toList()
          .length >
          0)
          .toList();
      filteredAsyncSubject.sort((a, b) => a.name.compareTo(b.name));
    }
    return new AsyncSubjectState(
      asyncSubjects: asyncSubjects ?? this.asyncSubjects,
      rawAsyncSubjects: rawAsyncSubjects ?? this.rawAsyncSubjects,
      filteredSubjects: filteredSubjects ?? this.filteredSubjects,
        filters : filteredAsyncSubject ?? this.filters
    );
  }

  List<AsyncSubject> getFilters() {
    final filters = this.rawAsyncSubjects;
    final filteredAsyncSubject = filters
        .where((element) =>
    element.gradeSubjects
        .expand((element) => element.classrooms)
        .toList()
        .length >
        0)
        .toList();
    filteredAsyncSubject.sort((a, b) => a.name.compareTo(b.name));
    return filteredAsyncSubject;
  }

  @override
  List<Object> get props => [asyncSubjects, rawAsyncSubjects, filteredSubjects];
}
