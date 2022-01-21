part of 'download_view_bloc.dart';

abstract class DownloadViewEvent extends Equatable {
  const DownloadViewEvent();
}

class LoadOfflineLessons extends DownloadViewEvent {
  @override
  List<Object> get props => [];
}

class DeleteLesson extends DownloadViewEvent {
  final Lessons lesson;
  DeleteLesson(this.lesson);

  @override
  List<Object> get props => [lesson];
}
