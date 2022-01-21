part of 'download_view_bloc.dart';

class DownloadViewState extends Equatable {
  const DownloadViewState({this.lessons, this.loading});

  final List<Lessons> lessons;
  final bool loading;

  DownloadViewState copyWith({
    List<Lessons> lessons,
    bool loading,
  }) {

    return new DownloadViewState(
      lessons: lessons ?? this.lessons,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [lessons, loading];
}



