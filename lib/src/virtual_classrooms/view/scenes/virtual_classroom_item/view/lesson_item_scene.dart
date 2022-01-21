import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/downloader/downloader.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/progress_lesson_enrollments_repository/lib/progress_lesson_enrollments_repository.dart';
import 'package:akademi_al_mobile_app/packages/quiz_user_response_repository/lib/quiz_user_response_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/user_commits_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/home/home.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/lesson_details.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/view/components/video_lesson_header.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/bloc/lesson_item_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/utils/lesson_item_utils.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'component/assignment_uploader.dart';
import 'component/bottom_lesson_item.dart';
import 'component/presentation_lesson_header.dart';

class LessonItemScene extends StatefulWidget {
  static Route route(
      Lessons lesson,
      EnrollmentEntity enrollmentEntity,
      Function reload,
      Function reroute,
      Function close,
      ClassroomEntity classroomEntity) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
          create: (context) {
            return LessonItemBloc(
                lessonRepository: LessonRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
                uploaderRepository: UploaderRepository(
                    RepositoryProvider.of<AuthenticationRepository>(context)),
                quizUserResponseRepository: QuizUserResponseRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
                progressLessonEnrollmentRepository:
                    ProgressLessonEnrollmentRepository(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(
                                context)),
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
                userCommitsRepository: UserCommitsRepository(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context)),
              userRepository: UserRepository(
                  authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(
                      context)),
            );
          },
          child: LessonItemScene(
            lesson: lesson,
            enrollmentEntity: enrollmentEntity,
            reload: reload,
            reroute: reroute,
            close: close,
            classroom: classroomEntity,
          )),
    );
  }

  final Lessons lesson;
  final EnrollmentEntity enrollmentEntity;
  final Function reload;
  final Function reroute;
  final Function close;
  final ClassroomEntity classroom;

  const LessonItemScene(
      {Key key,
      this.lesson,
      this.enrollmentEntity,
      this.reload,
      this.reroute,
      this.close,
      this.classroom})
      : super(key: key);

  @override
  _LessonItemSceneState createState() => _LessonItemSceneState();
}

class _LessonItemSceneState extends State<LessonItemScene> {
  var correctAnswers = 0;
  LessonItemUtils lessonItemUtils;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    double dragStart = 0.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
          onPressed: () => {
            if (widget.close != null) {widget.close()},
            Navigator.of(context).pop()
          },
        ),
        elevation: 1,
        title: InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil<void>(
              HomePage.route(false),
                  (route) => false,
            );
          },
          child: Image.asset(
            "assets/logos/akademi_logo/akademi_logo.png",
            width: 94.sp,
            height: 24.sp,
            fit: BoxFit.fill,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<LessonItemBloc, LessonItemState>(
          builder: (context, state) {
        if (state.loading == null || state.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  state.lessonEntity.lessonType == "VIDEO"
                      ? VideoLessonHeader(
                          lesson: state.lessonEntity,
                          playOffline: false,
                        )
                      : Container(),
                  state.lessonEntity.lessonType == "PDF"
                      ? PresentationLessonHeader(
                          lesson: state.lessonEntity,
                        )
                      : Container(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                TypeItem(
                                  itemType: state.lessonEntity.lessonType,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 12.0.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BaseText(
                                          text: state.lessonEntity.name,
                                          type: TextTypes.h5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // state.lessonEntity.file != null ? Expanded(child: Container()): Container(),
                          state.lessonEntity.file != null
                              ? Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Container()),
                                          !state.lessonEntity.localVideoUrls.contains(state.lessonEntity.userId)
                                          ? Downloader(
                                              onFinish: (filepath) {
                                                if (state.lessonEntity.lessonType == "VIDEO") {
                                                  context
                                                      .read<LessonItemBloc>()
                                                      .add(
                                                          SaveVideoLessonLocally(
                                                              filepath));

                                                  Flushbar(
                                                    flushbarPosition:
                                                        FlushbarPosition
                                                            .BOTTOM,
                                                    messageText: BaseText(
                                                      type: TextTypes.d1,
                                                      weightType:
                                                          FontWeight.w600,
                                                      text: s
                                                          .lesson_downloaded_succesfully,
                                                      textColor: Colors.white,
                                                    ),
                                                    backgroundColor:
                                                        AntColors.green6,
                                                    duration:
                                                        Duration(seconds: 2),
                                                  )..show(context);
                                                }
                                              },
                                              openFile: state.lessonEntity.lessonType == "VIDEO"
                                                  ? false
                                                  : true,
                                              file: state.lessonEntity.file,
                                              userId: state.lessonEntity.userId,
                                              child: Icon(
                                                  RemixIcons.download_fill,
                                                  color: AntColors.gray7),
                                            )
                                          : Icon(
                                              RemixIcons.download_fill,
                                              color: AntColors.green6,
                                            ),
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(width: 20.w)
                        ]),
                  ),
                  state.answers != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: 16.0.h, left: 20.w, right: 20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                RemixIcons.trophy_line,
                                color: AntColors.blue6,
                                size: 40.sp,
                              ),
                              BaseText(
                                text: s.correct_answer_number(
                                    lessonItemUtils
                                        .getCurrentNumberOfAnswers(state),
                                    state.lessonEntity.lessonMetaInfo.length),
                                textColor: AntColors.gray8,
                                type: TextTypes.p1,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Divider(
                                height: 1,
                              )
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 24.h,
                  ),
                  state.lessonEntity.endDate != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 20.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BaseText(
                                text: s.end_deadline,
                                type: TextTypes.d1,
                                textColor: AntColors.gray7,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              BaseText(
                                text: _getDate(),
                                type: TextTypes.d2,
                                textColor: AntColors.gray7,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Flexible(
                    child: LessonDetails(lesson: state.lessonEntity),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  state.lessonEntity.lessonType == "ASSIGNMENT"
                      ? Flexible(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: _getAssignmentView(state, s)))
                      : Container(),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: Material(
        elevation: 60,
        color: AntColors.blue1,
        child: Container(
          height: 108.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: BottomLessonItem(
                reload: widget.reload, reroute: widget.reroute),
          ),
        ),
      ),
    );
  }

  _getAssignmentView(LessonItemState state, S s) {
    if (lessonItemUtils.isAfterDeadline(state.lessonEntity)) {
      return Row(
        children: [
          Icon(
            RemixIcons.error_warning_line,
            size: 16.sp,
            color: AntColors.orange6,
          ),
          SizedBox(
            width: 6.w,
          ),
          BaseText(
            text: s.deadline_over,
            type: TextTypes.d1,
          )
        ],
      );
    } else {
      return AssignmentUploader(
        lesson: state.lessonEntity,
        assignmentUserCommit: state.assignmentUserCommit,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    lessonItemUtils = LessonItemUtils();
    context.read<LessonItemBloc>().add(LoadLesson(
        widget.lesson.id, widget.enrollmentEntity, widget.classroom));
  }

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    if (widget.lesson.endDate != null) {
      var date =
          formatter.format(DateTime.tryParse(widget.lesson.endDate)).toString();
      return date;
    } else {
      return "";
    }
  }
}
