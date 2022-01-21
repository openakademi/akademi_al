import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/bloc/async_classroom_item_bloc.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../lesson_item.dart';

class LessonTree extends StatefulWidget {
  final bool primaryList;

  const LessonTree({Key key, this.primaryList = true}) : super(key: key);

  @override
  _LessonTreeState createState() => _LessonTreeState();
}

class _LessonTreeState extends State<LessonTree> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AsyncClassroomItemBloc, AsyncClassroomItemState>(
        builder: (context, state) {
      // final groupedLessons = state.transformToChapters
      //     ? _transformToChapters(state.lessonsGroupedByWeek, state.chapters)
      //     : state.lessonsGroupedByWeek;
      final groupedLessons = state.lessonsGroupedByWeek;
      return ListView.builder(
        physics: widget.primaryList
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: groupedLessons != null ? groupedLessons.length : 0,
        itemBuilder: (context, index) {
          bool isExpanded = true;
          ExpandableController controller = ExpandableController(
            initialExpanded: state.isPreview != null && state.isPreview
                ? index == 0
                    ? true
                    : false
                : true,
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
                          turns: state.isPreview != null && state.isPreview
                              ? index == 0
                                  ? Tween(begin: 0.0, end: -0.25)
                                      .animate(animationController)
                                  : Tween(begin: -0.25, end: 0.0)
                                      .animate(animationController)
                              : Tween(begin: 0.0, end: -0.25)
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
                            onClick: !state.isPreview
                                ? () {
                                    context
                                        .read<AsyncClassroomItemBloc>()
                                        .add(LessonSelected(lesson.id));
                                  }
                                : null,
                            isSelected: !state.isPreview &&
                                state.selectedLesson.id == lesson.id,
                            lesson: lesson,
                            finished: state.lessonsFinished.firstWhere(
                                    (element) => element.id == lesson.id,
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
      );
    });
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
    return [];
  }
}
