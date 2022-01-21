import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/view/components/main_toggle_buttons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_not_async.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/bloc/virtual_classroom_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/view/lesson_item_scene.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VirtualClassroomContent extends StatefulWidget {
  final ClassroomEntity classroomEntity;
  final EnrollmentEntity enrollmentEntity;
  final String lessonId;
  final List<TagsNotAsync> tags;

  const VirtualClassroomContent(
      {Key key,
      this.classroomEntity,
      this.enrollmentEntity,
      this.lessonId,
      this.tags,
      })
      : super(key: key);

  @override
  _VirtualClassroomContentState createState() =>
      _VirtualClassroomContentState();
}

class _VirtualClassroomContentState extends State<VirtualClassroomContent>
    with TickerProviderStateMixin {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<VirtualClassroomContentBloc,
        VirtualClassroomContentState>(
      listenWhen: (previous, next) {
        return next.currentlyOpenedLesson != null &&
            previous.currentlyOpenedLesson != next.currentlyOpenedLesson;
      },
      listener: (context, state) {
        if (state.currentlyOpenedLesson != null &&
            state.currentlyOpenedLesson.isNotEmpty) {
          final lesson = state.filteredLessonsGrouped.values
              .expand((element) => element)
              .firstWhere(
                  (element) => element.id == state.currentlyOpenedLesson,
                  orElse: () => null);
          Navigator.of(context)
              .push(LessonItemScene.route(lesson, state.enrollmentEntity, () {
            context
                .read<VirtualClassroomContentBloc>()
                .add(ReloadSubjectPlanTree());
          }, () {
            context
                .read<VirtualClassroomContentBloc>()
                .add(ReloadSubjectPlanTree());
            context.read<VirtualClassroomContentBloc>().add(NextLesson());
          }, () {
            context
                .read<VirtualClassroomContentBloc>()
                .add(ReloadSubjectPlanTree());
            context.read<VirtualClassroomContentBloc>().add(LessonChanged(""));
          }, state.classroomEntity));
        }
      },
      child: BlocBuilder<VirtualClassroomContentBloc,
          VirtualClassroomContentState>(builder: (context, state) {
        final groupedLessons = state.filteredLessonsGrouped;
        print("Grouped Lessons");
        print(state.classroomContentTabIndex);
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: MainToggleButtons(items: state.tags != null ? state.tags : [], selectedIndex: state.classroomContentTabIndex),
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                header: MaterialClassicHeader(color: AntColors.blue6,),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: groupedLessons != null ? groupedLessons.length : 0,
                  itemBuilder: (context, index) {
                    bool isExpanded = true;
                    ExpandableController controller = ExpandableController(
                      initialExpanded: true,
                    );
                    final animationController = AnimationController(
                      duration: Duration(milliseconds: 100),
                      vsync: this,
                    );
                    return Column(
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 40.h,
                            color: AntColors.gray2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                              child: Row(
                                children: <Widget>[
                                  RotationTransition(
                                    turns: Tween(begin: 0.0, end: -0.25)
                                        .animate(animationController),
                                    child: Icon(
                                      RemixIcons.arrow_down_s_fill,
                                      size: 24.sp,
                                    ),
                                  ),
                                  BaseText(
                                    padding: EdgeInsets.only(left: 8.w),
                                    fontSize: 16.sp,
                                    weightType: FontWeight.w600,
                                    letterSpacing: -0.3,
                                    text: groupedLessons.keys.elementAt(index),
                                  ),
                                  Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: BaseText(
                                          type: TextTypes.d1,
                                          textColor: AntColors.blue6,
                                          text:
                                              "${_getFinishedCheckedLessons(groupedLessons.values.elementAt(index), state.lessonsFinished).length}/${groupedLessons.values.elementAt(index).length}",
                                        ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            if (isExpanded) {
                              animationController.forward();
                            } else {
                              animationController.reverse();
                            }
                            isExpanded = !isExpanded;
                            controller.toggle();
                          },
                        ),
                        ExpandableNotifier(
                          controller: controller,
                          child: Column(
                            children: [
                              Expandable(
                                expanded: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: groupedLessons.values.elementAt(index).length,
                                  itemBuilder: (context, index2) {
                                    final lesson = groupedLessons.values
                                        .elementAt(index)
                                        .elementAt(index2);
                                    return LessonItem(
                                      onClick: () {
                                        context
                                            .read<VirtualClassroomContentBloc>()
                                            .add(LessonChanged(lesson.id));
                                      },
                                      isSelected: false,
                                      lesson: lesson,
                                      finished: state.lessonsFinished?.firstWhere(
                                              (element) =>
                                                  element.id ==
                                                      groupedLessons.values
                                                          .elementAt(index)
                                                          .elementAt(index2)
                                                          .id,
                                              orElse: () => null) !=
                                          null,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _onRefresh() async {
    context.read<VirtualClassroomContentBloc>().add(LoadSubjectPlanTree(
      classroomEntity: widget.classroomEntity,
      enrollmentEntity: widget.enrollmentEntity,
      tags: widget.tags,
    ));
    _refreshController.refreshCompleted();
  }

  _transformToChapters(Map<String, List<Lessons>> lessonsGroupedByWeek,
      List<SubjectPlanTree> chapters) {
    var allLessons = lessonsGroupedByWeek?.values?.expand((element) => element);
    var map = groupBy<Lessons, String>(
        allLessons, (obj) => obj.subjectPlanTreeLessons.subjectPlanTreeId);
    return map
        .map((key, value) => MapEntry(_getChapterName(chapters, key), value));
  }

  _getChapterName(List<SubjectPlanTree> chapters, String id) {
    var result = "UNDEFINED";
    var resultChapter =
        chapters.firstWhere((element) => element.id == id, orElse: () => null);
    if (resultChapter != null) {
      result = resultChapter.name;
    }
    return result;
  }

  List<Lessons> _getFinishedCheckedLessons(
      List<Lessons> lessons, List<Lessons> lessonsFinished) {
    if (lessons != null && lessons.isNotEmpty) {
      return lessons
          .where((element) =>
      lessonsFinished != null &&
          lessonsFinished.isNotEmpty &&
          lessonsFinished.firstWhere(
                  (element1) => element1.id == element.id,
              orElse: () => null) !=
              null)
          .toList();
    }
  }


  @override
  void initState() {
    super.initState();
    print("ktu prap init");
    context.read<VirtualClassroomContentBloc>().add(LoadSubjectPlanTree(
        classroomEntity: widget.classroomEntity,
        enrollmentEntity: widget.enrollmentEntity,
        tags: widget.tags,
    ));


    if (widget.lessonId != null) {
      context
          .read<VirtualClassroomContentBloc>()
          .add(LessonChanged(widget.lessonId));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void didUpdateWidget(VirtualClassroomContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.classroomEntity.id != widget.classroomEntity.id) {
      context.read<VirtualClassroomContentBloc>().add(LoadSubjectPlanTree(
          classroomEntity: widget.classroomEntity,
          enrollmentEntity: widget.enrollmentEntity,
          tags: widget.tags,
      ));
    }
  }
}
