import 'dart:async';

import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'classrooms_event.dart';
part 'classrooms_state.dart';

class ClassroomsBloc extends Bloc<ClassroomsEvent, ClassroomsState> {
  ClassroomsBloc({this.enrollmentRepository, this.uploaderRepository}) : super(ClassroomsState());
  final EnrollmentRepository enrollmentRepository;
  final UploaderRepository uploaderRepository;

  @override
  Stream<ClassroomsState> mapEventToState(
    ClassroomsEvent event,
  ) async* {
    if(event is LoadClassrooms) {
      yield* _mapLoadClassroomsToState(event, state);
    }
  }

  Stream<ClassroomsState> _mapLoadClassroomsToState(LoadClassrooms event, ClassroomsState state) async* {
    yield state.copyWith(
        loading: true
    );
    final enrollments = await enrollmentRepository.getAllEnrollments();
    final enrollmentsWithPhotos = await Future.wait(enrollments.map((e) async {
      if(e.classroom.file != null) {
        try {
          final url = await uploaderRepository.getS3UrlForAction(
              "${e.classroom.file.filePath}/${e.classroom.file.name}",
              S3ActionType.DOWNLOAD);
          e.classroom.fileUrl = url;
        } catch(e) {
          print("$e");
        }
      }
      return e;
    }));
    yield state.copyWith(
      enrollments: enrollmentsWithPhotos,
      loading: false
    );
  }
}
