import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AssignmentTile extends StatefulWidget {
  final ClassroomEntity classroom;
  final Function navigateToClassroom;
  final List<AssignmentUserCommit> userCommits;

  const AssignmentTile(
      {Key key, this.classroom, this.navigateToClassroom, this.userCommits})
      : super(key: key);

  @override
  _AssignmentTileState createState() => _AssignmentTileState();
}

class _AssignmentTileState extends State<AssignmentTile> {
  Lessons nextAssignment;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return nextAssignment != null
        ? GestureDetector(
            onTap: () {
              if (widget.navigateToClassroom != null) {
                widget.navigateToClassroom(widget.classroom.id);
              } else {
                context.read<HomeBloc>().add(
                    VirtualClassPageChangedOpenedLesson(
                        navigationItem: NavigationItemKey.VIRTUAL_CLASSROOM,
                        selectedVirtualClassroomId: widget.classroom.id,
                        lessonId: nextAssignment.id));
              }
            },
            child: Container(
              height: 105,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AntColors.blue1,
                    child: Center(
                      child: Icon(
                        RemixIcons.MapForm[widget
                            .classroom.gradeSubject.subject.icon
                            .replaceAll("-", "_")],
                        size: 20.sp,
                        color: AntColors.blue6,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: widget.classroom.name,
                        type: TextTypes.d1,
                        weightType: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      BaseText(
                        text: s.next_assignment,
                        type: TextTypes.d2,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      BaseText(
                        text: nextAssignment.name,
                        type: TextTypes.d1,
                        textColor: AntColors.blue6,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            RemixIcons.timer_line,
                            color: AntColors.gray6,
                            size: 16.w,
                          ),
                          SizedBox(
                            width: 6.h,
                          ),
                          BaseText(
                            text: _getDate(),
                            type: TextTypes.d2,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  ))
                ],
              ),
            ),
          )
        : Container();
  }

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    var date =
        formatter.format(DateTime.tryParse(nextAssignment.endDate)).toString();
    return date;
  }

  @override
  void initState() {
    super.initState();
    final allLessons = widget.classroom.subjectPlan.subjectPlanTree.lessons;
    if (allLessons != null) {
      allLessons.sort((a, b) {
        final aEndDate =
            a.endDate != null ? DateTime.tryParse(a.endDate) : DateTime.now();
        final bEndDate =
            b.endDate != null ? DateTime.tryParse(b.endDate) : DateTime.now();
        return aEndDate.compareTo(bEndDate);
      });
      List<Lessons> _lessons = [];
      if (allLessons != null && allLessons.length > 0) {
        _lessons = allLessons.where((element) {
          int index =
              widget.userCommits.indexWhere((e) => e.lessonId == element.id);
          if (index == -1) {
            return true;
          }
          return false;
        }).toList();
      }
      print(_lessons);
      nextAssignment = _lessons.length > 0 ? _lessons[0] : null;
    }
  }

}
