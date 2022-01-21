import 'package:akademi_al_mobile_app/components/button/lib/main_text_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/classrooms/view/components/virtual_class_tile.dart';
import 'package:akademi_al_mobile_app/src/dashboard/bloc/dashboard_bloc.dart';
import 'package:akademi_al_mobile_app/src/dashboard/view/scenes/all_assignments.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/async_classroom_item.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/view/scenes/async_classrooms_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'components/assignment_tile.dart';
import 'components/welcome_user.dart';
import 'continue_lesson_all_screen.dart';
import 'scenes/subjects_scene.dart';

class DashboardScene extends StatefulWidget {
  final List<EnrollmentEntity> allEnrollments;

  const DashboardScene({Key key, this.allEnrollments}) : super(key: key);

  @override
  _DashboardSceneState createState() => _DashboardSceneState();
}

class _DashboardSceneState extends State<DashboardScene> {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 10.h),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _SliverAppBarDelegate(
                  child: PreferredSize(
                child: WelcomeUser(),
                preferredSize: Size.fromHeight(86.h),
              ))),
          SliverToBoxAdapter(
            child: BlocBuilder<DashboardBloc, DashboardState>(
                buildWhen: (previous, next) {
              return next.allEnrollments != null;
            }, builder: (context, state) {
              if (state.allEnrollments == null) {
                return Container(
                  height: 280,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Padding(
                  padding:
                      EdgeInsets.only(top: 16.0.h, left: 20.w, right: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: s.continue_lesson,
                            type: TextTypes.h4,
                          ),
                          state.allEnrollments
                                      .where((element) =>
                                          !element.classroom.isAsync)
                                      .toList()
                                      .length !=
                                  0
                              ? MainTextButton(
                                  onPress: () {
                                    _showVirtualClassroomsListModal(state);
                                  },
                                  text: s.all_number(
                                      state.allEnrollments.toList().length),
                                )
                              : Container()
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        height: 280.h,
                        child: state.allEnrollments.length == 0
                            ? Padding(
                                padding: EdgeInsets.only(top: 16.0.h),
                                child: Container(
                                  height: 131.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AntColors.blue1,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      Icon(
                                        RemixIcons.login_box_line,
                                        color: AntColors.blue6,
                                        size: 24.sp,
                                      ),
                                      SizedBox(
                                        height: 11.h,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0.w),
                                          child: BaseText(
                                            align: TextAlign.center,
                                            text:
                                                s.not_part_of_any_virtual_class,
                                            textColor: AntColors.gray7,
                                            lineHeight: 1.5,
                                            type: TextTypes.d2,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 16.w,
                                  );
                                },
                                padding: EdgeInsets.zero,
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: state?.allEnrollments.length,
                                itemBuilder: (context, index) {
                                  final classroom = state.allEnrollments
                                      .toList()[index]
                                      .classroom;
                                  final enrollment =
                                      state.allEnrollments.toList()[index];
                                  return VirtualClassTile(
                                    enrollment: enrollment,
                                    classroom: classroom,
                                    classroomId: enrollment.classroomId,
                                    onClick: classroom.isAsync
                                        ? () {
                                            Navigator.of(context).push(
                                                AsyncClassroomItem.route(
                                                    enrollment.classroomId,
                                                    classroom.fileUrl, null));
                                          }
                                        : null,
                                  );
                                }),
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
          _getAsyncSubjectsGrid(s),
          _getAssignmentsList(s)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboard(widget.allEnrollments));
  }

  _getAsyncSubjectsGrid(S s) {
    return SliverToBoxAdapter(
      child: BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (previous, next) {
        return next.asyncSubjects != null;
      }, builder: (context, state) {
        if (state.asyncSubjects == null) {
          return Container(
            height: 280,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 16.0.h, left: 20.w, right: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText(
                      text: s.subjects,
                      type: TextTypes.h4,
                      textColor: AntColors.gray8,
                    ),
                    MainTextButton(
                        onPress: () {
                          Navigator.of(context)
                              .push(SubjectDashboardScene.route());
                          // context.read<HomeBloc>().add(NavigationItemChanged(
                          //     NavigationItemKey.SUBJECTS, "", null));
                        },
                        text: s.all)
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints:
                          BoxConstraints(minHeight: 100, maxHeight: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                              direction: Axis.horizontal,
                              spacing: 16.w,
                              children: state.asyncSubjects
                                  .getRange(0,
                                      (state.asyncSubjects.length / 2).round())
                                  .map<Widget>((e) => GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              AsyncClassroomsList.route(e));
                                        },
                                        child: Chip(
                                          padding: EdgeInsets.only(
                                              left: 6.w, right: 6.w),
                                          backgroundColor: AntColors.blue1,
                                          avatar: Icon(
                                            RemixIcons.MapForm[
                                                e.icon.replaceAll("-", "_")],
                                            size: 20.sp,
                                            color: AntColors.blue6,
                                          ),
                                          label: BaseText(
                                            text: e.name,
                                            textColor: AntColors.blue6,
                                            overflow: TextOverflow.visible,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ))
                                  .toList()),
                          Wrap(
                              spacing: 16.w,
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: state.asyncSubjects
                                  .getRange(
                                      (state.asyncSubjects.length / 2).round(),
                                      state.asyncSubjects.length)
                                  .map<Widget>((e) => GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              AsyncClassroomsList.route(e));
                                        },
                                        child: Chip(
                                          padding: EdgeInsets.only(
                                              left: 6.w, right: 6.w),
                                          backgroundColor: AntColors.blue1,
                                          avatar: Icon(
                                            RemixIcons.MapForm[
                                                e.icon.replaceAll("-", "_")],
                                            size: 20.sp,
                                            color: AntColors.blue6,
                                          ),
                                          label: BaseText(
                                            text: e.name,
                                            textColor: AntColors.blue6,
                                            overflow: TextOverflow.visible,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ))
                                  .toList()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  _getAssignmentsList(S s) {
    return SliverToBoxAdapter(
      child: BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (previous, next) {
        return next.classrooms != null;
      }, builder: (context, state) {
        if (state.assignments == null) {
          return Container(
            height: 280,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (state.assignments.length == 0) {
            return Padding(
              padding: EdgeInsets.only(top: 16.0.h, left: 20.w, right: 20.w, bottom: 50.h),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: s.assignments,
                      type: TextTypes.h4,
                      textColor: AntColors.gray8,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/empty_classroom/empty_classroom.png",
                            fit: BoxFit.cover,
                            width: 106.w,
                            height: 100.h,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          BaseText(
                            align: TextAlign.center,
                            text: s.empty_dashboard_assignments,
                            type: TextTypes.d1,
                            textColor: AntColors.gray8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 16.0.h, left: 20.w, right: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText(
                      text: s.assignments,
                      type: TextTypes.h4,
                      textColor: AntColors.gray8,
                    ),
                    MainTextButton(
                        onPress: () {
                          Navigator.of(context).push(AllAssignments.route(
                              state.classrooms, (String classroomId) {
                            context.read<HomeBloc>().add(NavigationItemChanged(
                                NavigationItemKey.VIRTUAL_CLASSROOM,
                                classroomId,
                                null));
                          }, state.userCommits));
                        },
                        text: s.all)
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.w,
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state?.classrooms.length,
                    itemBuilder: (context, index) {
                      return AssignmentTile(
                        classroom: state.classrooms[index],
                        userCommits: state.userCommits
                      );
                    }),
              ],
            ),
          );
        }
      }),
    );
  }

  _showVirtualClassroomsListModal(DashboardState state) {
    showCupertinoModalBottomSheet(
        context: this.context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return ContinueLessonAll(
            enrollments: state.allEnrollments.toList(),
            onTap: (ClassroomEntity classroomEntity) {
              if (classroomEntity.isAsync) {
                Navigator.of(context).push(AsyncClassroomItem.route(classroomEntity.id, "", null));
              } else {
                context.read<HomeBloc>().add(NavigationItemChanged(
                    NavigationItemKey.VIRTUAL_CLASSROOM,
                    classroomEntity.id,
                    null));
              }
            },
          );
        });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
