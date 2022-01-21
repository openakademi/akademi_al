import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/feed_repository/feed_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/subject_plan_tree_repository/lib/subject_plan_tree_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/user_commits_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/bloc/virtual_classroom_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/bloc/virtual_classroom_home_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_homework/bloc/virtual_classroom_homework_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/virtual_classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VirtualClassroomProvider extends StatelessWidget {
  final String classroomId;
  final EnrollmentEntity enrollmentEntity;
  final Function testActions;
  final Key stateKey;
  final String lessonId;

  const VirtualClassroomProvider(
      {Key key,
      this.classroomId,
      this.enrollmentEntity,
      this.testActions,
      this.stateKey,
      this.lessonId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return VirtualClassroomBloc(
                classroomRepository: ClassroomRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
                userRepository: UserRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
                enrollmentRepository:
                    RepositoryProvider.of<EnrollmentRepository>(context),
                subjectPlanTreeRepository: SubjectPlanTreeRepository(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                ),
                organizationRepository: OrganizationRepository()
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return VirtualClassroomHomeBloc(
                  classroomRepository: ClassroomRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  ),
                  userRepository: UserRepository(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context)),
                  enrollmentRepository:
                      RepositoryProvider.of<EnrollmentRepository>(context),
                  feedRepository: FeedRepository(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context)));
            },
          ),
          BlocProvider(
            // lazy: false,
            create: (context) {
              return VirtualClassroomContentBloc(
                  subjectPlanTreeRepository: SubjectPlanTreeRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  ),
                  enrollmentRepository:
                      RepositoryProvider.of<EnrollmentRepository>(context),
                  organizationRepository: OrganizationRepository());
            },
          ),
          BlocProvider(
            create: (context) {
              return VirtualClassroomHomeworkBloc(
                  subjectPlanTreeRepository: SubjectPlanTreeRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  ),
                  userCommitsRepository: UserCommitsRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  ));
            },
          ),
        ],
        child: VirtualClassroomScene(
          key: stateKey,
          classroomId: classroomId,
          enrollmentEntity: enrollmentEntity,
          testActions: testActions,
          lessonId: lessonId,
        ));
  }
}
