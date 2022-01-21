import 'package:akademi_al_mobile_app/components/button/button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/src/subjects/quiz/quiz.dart' as QuizUtils;
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/bloc/lesson_item_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/utils/lesson_item_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomLessonItem extends StatelessWidget {
  final Function reload;
  final Function reroute;
  LessonItemUtils lessonItemUtils;

  BottomLessonItem({Key key, this.reload, this.reroute}) : super(key: key) {
    lessonItemUtils = LessonItemUtils();
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocBuilder<LessonItemBloc, LessonItemState>(
      builder: (context, state) {
        return Center(
            child: state.loading == null || state.loading
                ? Container()
                : _getButton(state.lessonEntity, s, state.lessonDone, context,
                    state.enrollmentEntity, state));
      },
    );
  }

  _getButton(Lessons lesson, S s, bool lessonDone, BuildContext context,
      EnrollmentEntity enrollmentEntity, LessonItemState state) {
    if (lesson.lessonType == "VIDEO" || lesson.lessonType == "PDF") {
      return lessonDone == null || !lessonDone
          ? Row(
              children: [
                Expanded(
                  child: MainButton(
                    size: ButtonSize.Small,
                    width: 134.w,
                    height: 44.h,
                    disabled: state.submitting != null && state.submitting,
                    onPress: () {
                      context.read<LessonItemBloc>().add(EndLesson());
                      if (reload != null) {
                        reload();
                      }
                      // context.read<VirtualClassroomContentBloc>().add(ReloadSubjectPlanTree());
                    },
                    text: s.end_lesson,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                MainButton(
                  size: ButtonSize.Small,
                  width: 44.h,
                  height: 44.h,
                  ghost: true,
                  disabled: state.submitting != null && state.submitting,
                  onPress: () {
                    if (reroute != null) {
                      reroute();
                    }
                    Navigator.of(context).pop();
                  },
                  iconButton: Icon(
                    RemixIcons.arrow_right_line,
                    color: AntColors.blue6,
                    size: 18.sp,
                  ),
                ),
              ],
            )
          : _getNextLessonButton(context, s);
    } else if (lesson.lessonType == "QUIZ") {
      return lessonDone == null || !lessonDone
          ? Row(
              children: [
                Expanded(
                  child: MainButton(
                    size: ButtonSize.Small,
                    width: 134.w,
                    height: 44.h,
                    disabled: state.submitting != null && state.submitting,
                    onPress: () {
                      QuizUtils.Quiz quiz = QuizUtils.Quiz();
                      quiz.showFilterBottomSheet(
                          context, lesson, enrollmentEntity.id, () {
                        context.read<LessonItemBloc>().add(EndLesson());
                      }, null);
                      if (reload != null) {
                        reload();
                      }
                    },
                    text: s.start_quiz,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                MainButton(
                  size: ButtonSize.Small,
                  width: 44.h,
                  height: 44.h,
                  ghost: true,
                  disabled: state.submitting != null && state.submitting,
                  onPress: () {
                    if (reroute != null) {
                      reroute();
                    }
                    Navigator.of(context).pop();
                  },
                  iconButton: Icon(
                    RemixIcons.arrow_right_line,
                    color: AntColors.blue6,
                    size: 18.sp,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: MainButton(
                    size: ButtonSize.Small,
                    width: 134.w,
                    height: 44.h,
                    disabled: state.submitting != null && state.submitting,
                    onPress: () {
                      QuizUtils.Quiz quiz = QuizUtils.Quiz();
                      quiz.showFilterBottomSheet(
                          context, lesson, enrollmentEntity.id, () {
                        context.read<LessonItemBloc>().add(EndLesson());
                      }, null);
                      // context.read<LessonItemBloc>().add(EndLesson());
                      if (reload != null) {
                        reload();
                      }
                    },
                    text: s.redo_quiz,
                    prefixIcon: Icon(
                      RemixIcons.refresh_line,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                MainButton(
                  size: ButtonSize.Small,
                  width: 44.h,
                  height: 44.h,
                  ghost: true,
                  disabled: state.submitting != null && state.submitting,
                  onPress: () {
                    if (reroute != null) {
                      reroute();
                    }
                    Navigator.of(context).pop();
                  },
                  iconButton: Icon(
                    RemixIcons.arrow_right_line,
                    color: AntColors.blue6,
                    size: 18.sp,
                  ),
                ),
              ],
            );
    } else if (lesson.lessonType == "MEETING") {
      return Row(
        children: [
          Expanded(
            child: MainButton(
              size: ButtonSize.Small,
              width: 134.w,
              height: 44.h,
              disabled: state.submitting != null && state.submitting,
              onPress: () async {
                if (await canLaunch(lesson.zoomLesson.joinUrl)) {
                  await launch(lesson.zoomLesson.joinUrl);
                }
                if (reload != null) {
                  reload();
                }
              },
              text: s.open_zoom,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          MainButton(
            size: ButtonSize.Small,
            width: 44.h,
            height: 44.h,
            ghost: true,
            disabled: state.submitting != null && state.submitting,
            onPress: () {
              if (reroute != null) {
                reroute();
              }
              Navigator.of(context).pop();
            },
            iconButton: Icon(
              RemixIcons.arrow_right_line,
              color: AntColors.blue6,
              size: 18.sp,
            ),
          ),
        ],
      );
    } else if (lesson.lessonType == "ASSIGNMENT") {
      if (lessonItemUtils.isAfterDeadline(lesson)) {
        return MainButton(
          size: ButtonSize.Small,
          disabled: false,
          ghost: true,
          width: 134.w,
          height: 52.h,
          onPress: () {
            if (reroute != null) {
              reroute();
            }
            Navigator.of(context).pop();
          },
          text: s.next_lesson,
        );
      } else {
        return lessonDone == null || !lessonDone
            ? Row(
                children: [
                  Expanded(
                    child: MainButton(
                      size: ButtonSize.Small,
                      width: 134.w,
                      height: 44.h,
                      prefixIcon: Icon(
                        RemixIcons.send_plane_line,
                        color: state.assignmentUserCommit == null ||
                            (state.submitting != null && state.submitting) ? AntColors.gray6 : Colors.white,
                        size: 18.sp,
                      ),
                      disabled: state.assignmentUserCommit == null ||
                          (state.submitting != null && state.submitting),
                      onPress: () {
                        showConfirmModal(context, state, () {
                          context.read<LessonItemBloc>().add(EndLesson());
                        });
                      },
                      text: s.turn_in_assignment,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  MainButton(
                    size: ButtonSize.Small,
                    width: 44.h,
                    height: 44.h,
                    ghost: true,
                    disabled: state.submitting != null && state.submitting,
                    onPress: () {
                      if (reroute != null) {
                        reroute();
                      }
                      Navigator.of(context).pop();
                    },
                    iconButton: Icon(
                      RemixIcons.arrow_right_line,
                      color: AntColors.blue6,
                      size: 18.sp,
                    ),
                  ),
                ],
              )
            : _getNextLessonButton(context, s);
      }
    }
  }

  showConfirmModal(
      BuildContext context, LessonItemState state, Function endLesson) {
    final s = S.of(context);
    showModalBottomSheet(
        context: context,
        elevation: 4,
        barrierColor: Color.fromRGBO(22, 24, 35, 0.4),
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24.0.h),
                        child: Center(
                          child: Container(
                            width: 56.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: AntColors.gray3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.only(
                              top: 16.h, bottom: 16.h, right: 16.w),
                          icon: Icon(RemixIcons.close_fill),
                          iconSize: 24.sp,
                          color: AntColors.gray6,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                  BaseText(
                    text: s.turn_in_assignment,
                    fontSize: 20.sp,
                    letterSpacing: -1,
                    lineHeight: 1.3,
                    weightType: FontWeight.w600,
                    align: TextAlign.center,
                  ),
                  Divider(
                    color: AntColors.gray6,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: RichText(
                      text: new TextSpan(
                          style: defaultTextStyles[TextTypes.p2],
                          children: [
                            TextSpan(
                                text: s.you_are_turning_in_assignment_for("")),
                            TextSpan(
                              style: TextStyle(
                                fontWeight:FontWeight.w600
                              ),
                                text: state.lessonEntity.name)
                          ]),
                    ),
                    // BaseText(
                    //             text: s.you_are_turning_in_assignment_for(
                    //                 state.lessonEntity.name),
                    //           ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Row(
                      children: [
                        Icon(
                          RemixIcons.error_warning_line,
                          size: 16.sp,
                          color: AntColors.orange6,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Expanded(
                          child: BaseText(
                            text: s.you_can_turn_in_assignment_only_one,
                            type: TextTypes.d1,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 16.h),
                    child: MainButton(
                      size: ButtonSize.Small,
                      width: 134.w,
                      height: 44.h,
                      prefixIcon: Icon(
                        RemixIcons.send_plane_line,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      onPress: () {
                        if (endLesson != null) {
                          endLesson();
                        }
                        if (reload != null) {
                          reload();
                        }
                        Navigator.of(context).pop();
                      },
                      text: s.turn_in_assignment,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getNextLessonButton(BuildContext context, S s) {
    return MainButton(
      size: ButtonSize.Small,
      disabled: false,
      ghost: true,
      width: 134.w,
      height: 52.h,
      onPress: () {
        if (reroute != null) {
          reroute();
        }
        Navigator.of(context).pop();
      },
      text: s.next_lesson,
    );
  }
}
