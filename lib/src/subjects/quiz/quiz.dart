import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/progress_lesson_enrollments_repository/lib/progress_lesson_enrollments_repository.dart';
import 'package:akademi_al_mobile_app/packages/quiz_user_response_repository/lib/quiz_user_response_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/bloc/async_classroom_item_bloc.dart';
import 'package:akademi_al_mobile_app/src/subjects/quiz/bloc/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'view/quiz.dart';

class Quiz {
  showFilterBottomSheet(context, Lessons lesson, String enrollmentId,Function endLesson, AsyncClassroomItemBloc bloc) {
    showCupertinoModalBottomSheet(
        context: context,
        enableDrag: false,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return BlocProvider(
            create: (context) {
              return QuizBloc(
                  lessonRepository: LessonRepository(
                      authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(
                          context)),
                uploaderRepository: UploaderRepository(
                    RepositoryProvider.of<AuthenticationRepository>(context)),
                quizUserResponseRepository: QuizUserResponseRepository(authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context)
                ),
                authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
                progressLessonEnrollmentRepository: ProgressLessonEnrollmentRepository(
                  authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)
                )
              );
            },
            child: QuizModal(lesson: lesson, enrollmentId: enrollmentId, parentBloc: bloc, endLesson: endLesson,),
          );
        });
  }
}
