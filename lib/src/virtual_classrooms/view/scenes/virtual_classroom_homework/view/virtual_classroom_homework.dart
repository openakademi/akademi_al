import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_homework/bloc/virtual_classroom_homework_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'components/assignment_entry.dart';

class VirtualClassroomHomework extends StatefulWidget {
  final String classroomId;
  final String subjectPlanId;

  const VirtualClassroomHomework(
      {Key key,
      this.classroomId,
      this.subjectPlanId})
      : super(key: key);

  @override
  _VirtualClassroomHomeworkState createState() =>
      _VirtualClassroomHomeworkState();
}

class _VirtualClassroomHomeworkState extends State<VirtualClassroomHomework> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocBuilder<VirtualClassroomHomeworkBloc,
        VirtualClassroomHomeworkState>(builder: (context, state) {
      if (state.loading == null || state.loading) {
        return SkeletonList();
      }
      return state.assignments.length != 0
          ? Container(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 40.h,
                  color: AntColors.blue1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.w),
                      child: BaseText(
                        text: s.homework,
                        type: TextTypes.h6,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: SmartRefresher(
                      enablePullDown: true,
                      header: MaterialClassicHeader(color: AntColors.blue6,),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.filteredAssignments.length,
                          itemBuilder: (context, index) {
                            final assignment = state.filteredAssignments[index];
                            return AssignmentEntry(
                                assignment: assignment,
                                userCommit: _getUserCommitForAssignment(
                                    assignment, state.userCommits));
                          }),
                    ),
                  ),
                )
              ],
            ))
          : Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/empty_homework/empty_homework.png",
                        fit: BoxFit.cover,
                        width: 106.w,
                        height: 100.h,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      BaseText(
                        align: TextAlign.center,
                        text: s.no_homework_virtual_class,
                        type: TextTypes.d1,
                        textColor: AntColors.gray8,
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  void _onRefresh() async {
    context.read<VirtualClassroomHomeworkBloc>().add(LoadAssignments(
        classroomId: widget.classroomId,
        subjectPlanId: widget.subjectPlanId));
    _refreshController.refreshCompleted();
  }

  _getUserCommitForAssignment(
      Lessons assignment, List<AssignmentUserCommit> userCommits) {
    return userCommits.firstWhere(
        (element) => element.lessonId == assignment.id,
        orElse: () => null);
  }

  @override
  void initState() {
    super.initState();
    context.read<VirtualClassroomHomeworkBloc>().add(LoadAssignments(
        classroomId: widget.classroomId,
        subjectPlanId: widget.subjectPlanId));
  }
}
