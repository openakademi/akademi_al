import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/bloc/virtual_classroom_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AssignmentEntry extends StatelessWidget {
  final Lessons assignment;
  final AssignmentUserCommit userCommit;

  const AssignmentEntry({Key key, this.assignment, this.userCommit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return GestureDetector(
      onTap: () {
        context
            .read<VirtualClassroomBloc>()
            .add(LessonChangedEvent(assignment.id));
      },
      child: Container(
        height: 80.h,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TypeItem(
              itemType: assignment.lessonType,
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text: assignment.name,
                  type: TextTypes.d1,
                ),
                SizedBox(
                  height: 2.h,
                ),
                assignment.endDate != null
                    ? BaseText(
                        type: TextTypes.d2,
                        text: _getDate(),
                        textColor: AntColors.gray7,
                      )
                    : Container(),
                userCommit != null
                    ? SizedBox(
                        height: 4.h,
                      )
                    : Container(),
                userCommit != null ? _getIsEvaluated(s) : Container()
              ],
            ),
            Expanded(
                child:
                    Align(alignment: Alignment.centerRight, child: _getSent()))
          ],
        ),
      ),
    );
  }

  _getIsEvaluated(S s) {
    if (userCommit.isCommitted && userCommit.isEvaluated) {
      return BaseText(
        text: s.grade_evaluation(userCommit.grade),
        type: TextTypes.d1,
        weightType: FontWeight.w600,
      );
    }

    if (userCommit.isCommitted &&
        !userCommit.isEvaluated &&
        !_checkIsAvaiable()) {
      return Container(
        height: 22.h,
        width: 85.w,
        color: AntColors.gold1,
        child: Center(
          child: BaseText(
            text: s.evaluating,
            textColor: AntColors.gold6,
            type: TextTypes.d2,
          ),
        ),
      );
    }

    if (userCommit.isCommitted &&
        !userCommit.isEvaluated &&
        _checkIsAvaiable()) {
      return Container(
        height: 22.h,
        width: 85.w,
        color: AntColors.blue1,
        child: Center(
          child: BaseText(
            text: s.not_evaluated,
            textColor: AntColors.blue6,
            type: TextTypes.d2,
          ),
        ),
      );
    }
    return Container();
  }

  _getSent() {
    if (userCommit != null && userCommit.isCommitted) {
      return Icon(
        RemixIcons.checkbox_circle_fill,
        size: 16.sp,
        color: AntColors.green6,
      );
    }
    if (userCommit == null && !_checkIsAvaiable()) {
      return Icon(
        RemixIcons.close_circle_fill,
        size: 16.sp,
        color: AntColors.red6,
      );
    }

    if (userCommit == null && _checkIsAvaiable()) {
      return Icon(
        RemixIcons.time_fill,
        size: 16.sp,
        color: AntColors.gray6,
      );
    }
  }

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    var date =
        formatter.format(DateTime.tryParse(assignment.endDate)).toString();
    return date;
  }

  _checkIsAvaiable() {
    final today = DateTime.now();
    if(assignment.endDate != null) {
      final endDate = DateTime.tryParse(assignment.endDate);
      return today.compareTo(endDate) <= 0;
    } else {
      return false;
    }
  }
}
