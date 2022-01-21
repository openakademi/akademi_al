import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'download_view_event.dart';
part 'download_view_state.dart';

class DownloadViewBloc extends Bloc<DownloadViewEvent, DownloadViewState> {
  DownloadViewBloc({this.lessonRepository, this.authenticationRepository}) : super(DownloadViewState());
  final LessonRepository lessonRepository;
  final AuthenticationRepository authenticationRepository;
  @override
  Stream<DownloadViewState> mapEventToState(
    DownloadViewEvent event,
  ) async* {
    if(event is LoadOfflineLessons) {
      yield* _mapLoadOfflineLessonsToState(event, state);
    } else if(event is DeleteLesson) {
      yield* _mapDeleteLessonToState(event, state);
    }

  }

  Stream<DownloadViewState>_mapLoadOfflineLessonsToState(LoadOfflineLessons event, DownloadViewState state) async* {

    yield state.copyWith(
      loading: true
    );
    final userId = await authenticationRepository.getCurrentUserId();
    final lessons = await lessonRepository.getAllLocallySavedLessons(userId);
    String dirloc = "";
    if (Platform.isAndroid) {
      dirloc =  await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }

    final lessonsToShow = await Future.wait(lessons.map((e) async{
      final fileName = e.file.id + p.extension(e.file.name);
      /// Shohim nese ka video te folderi "Download, nese ka i marrim i vendosim ne folderin e ri te krijuar me UserId
      final checkOldPathExistence = await File("$dirloc/$fileName").exists();
      if(checkOldPathExistence){
        String path = await createUserFolderInDownloadDir("$dirloc/$userId");
        await File("$dirloc/$fileName").rename("$path/$fileName");
      }
      /// Kontrollojme nese video eshte fshire ose jo nga folderi
      final checkPathExistence = await File("$dirloc/$userId/$fileName").exists();
      if(checkPathExistence) {
        final size = Platform.isAndroid ? await _getFileSize(
            "$dirloc/$userId/$fileName") : await _getFileSize(
            "$dirloc/$userId/$fileName");
        e.fileSize = size;
        return e;
      }
    }));

    lessonsToShow.removeWhere((value) => value == null);
    yield state.copyWith(
      loading: false,
      lessons: lessonsToShow.toList()
    );
  }

  static Future<String> createUserFolderInDownloadDir(String folderPath) async {
    if(await Directory(folderPath).exists()){ //if folder already exists return path
      return Directory(folderPath).path;
    }else{//if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder=await Directory(folderPath).create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  Stream<DownloadViewState> _mapDeleteLessonToState(DeleteLesson event, DownloadViewState state) async* {
    yield state.copyWith(loading: true);
    var path;
    if(Platform.isAndroid) {
      path = await ExtStorage.getExternalStoragePublicDirectory('${ExtStorage.DIRECTORY_DOWNLOADS}/${event.lesson.userId}');
    } else {
      path = (await getApplicationDocumentsDirectory()).uri.path+ '/${event.lesson.userId}';
    }
    await File('${path + '/' + event.lesson.file.id + p.extension(event.lesson.file.name)}').delete();
    await lessonRepository.deleteSavedLessonById(event.lesson.id);
    yield state.copyWith(loading: false);
  }


  Future<String> _getFileSize(String localUrl) async {
    File file = File(localUrl);
    var size = 0;
    try {
       size = file.lengthSync();
    } catch (e) {
      print("e");
    }
    return formatBytes(size, 1);
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }
}
