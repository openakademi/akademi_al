import 'package:akademi_al_mobile_app/components/button/lib/main_text_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/classrooms/bloc/classrooms_bloc.dart';
import 'package:akademi_al_mobile_app/src/classrooms/view/scenes/asynch_classrooms_list.dart';
import 'package:akademi_al_mobile_app/src/classrooms/view/scenes/virtual_classrooms_list.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/virtual_classroom_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'components/async_class_tile.dart';
import 'components/virtual_class_tile.dart';

class ClassroomsScene extends StatefulWidget {
  @override
  _ClassroomsSceneState createState() => _ClassroomsSceneState();
}

class _ClassroomsSceneState extends State<ClassroomsScene> {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return BlocBuilder<ClassroomsBloc, ClassroomsState>(
        builder: (context, state) {
      if (state.loading == null || state.loading) {
        return SkeletonList();
      } else {
        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        text: s.virtual_classrooms,
                        type: TextTypes.h4,
                      ),
                      state?.enrollments
                                  .where(
                                      (element) => !element.classroom.isAsync)
                                  .toList()
                                  .length !=
                              0
                          ? MainTextButton(
                              onPress: () {
                                _showVirtualClassroomsListModal(state);
                              },
                              text: s.all_number(state?.enrollments
                                  .where(
                                      (element) => !element.classroom.isAsync)
                                  .toList()
                                  .length),
                            )
                          : Container()
                    ],
                  ),
                  state?.enrollments
                              .where((element) => !element.classroom.isAsync)
                              .toList()
                              .length ==
                          0
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      text: s.not_part_of_any_virtual_class,
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
                      : _getAsynchClassList(state, s),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        text: s.async_classrooms,
                        type: TextTypes.h4,
                      ),
                      MainTextButton(
                        onPress: () {
                          _showAsynchClassroomsList(state);
                        },
                        text: s.all_number(state?.enrollments
                            .where((element) => element.classroom.isAsync)
                            .toList()
                            .length),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 350.h,
                    child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.enrollments
                            .where((element) => element.classroom.isAsync)
                            .toList()
                            .length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 24.h,
                                crossAxisSpacing: 20.w,
                                childAspectRatio: 1.01),
                        itemBuilder: (context, index) {
                          final classroom = state.enrollments
                              .where((element) => element.classroom.isAsync)
                              .toList()[index]
                              .classroom;
                          final enrollment = state.enrollments
                              .where((element) => element.classroom.isAsync)
                              .toList()[index];
                          return AsyncClassTile(
                            enrollment: enrollment,
                            classroom: classroom,
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  _getAsynchClassList(ClassroomsState state, S s) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: SizedBox(
        height: 280.h,
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 16.w,
              );
            },
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state?.enrollments
                .where((element) => !element.classroom.isAsync)
                .toList()
                .length,
            itemBuilder: (context, index) {
              final classroom = state.enrollments
                  .where((element) => !element.classroom.isAsync)
                  .toList()[index]
                  .classroom;
              final enrollment = state.enrollments
                  .where((element) => !element.classroom.isAsync)
                  .toList()[index];
              return VirtualClassTile(
                enrollment: enrollment,
                classroom: classroom,
                classroomId: enrollment.classroomId,
              );
            }),
      ),
    );
  }

  _showVirtualClassroomsListModal(ClassroomsState state) {
    showCupertinoModalBottomSheet(
        context: this.context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return VirtualClassroomsList(
            enrollments: state.enrollments
                .where((element) => !element.classroom.isAsync)
                .toList(),
            onTap: (ClassroomEntity classroomEntity) {
              context.read<HomeBloc>().add(NavigationItemChanged(
                  NavigationItemKey.VIRTUAL_CLASSROOM,
                  classroomEntity.id,
                  null));
            },
            openAddClassroomModal: () {
              VirtualClassroomUtils().showFilterBottomSheet(this.context);
            },
          );
        });
  }

  _showAsynchClassroomsList(ClassroomsState state) {
    showCupertinoModalBottomSheet(
        context: this.context,
        expand: true,
        elevation: 40,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return AsynchClassroomsList(
            enrollments: state.enrollments
                .where((element) => element.classroom.isAsync)
                .toList(),
          );
        });
  }

  @override
  void didUpdateWidget(ClassroomsScene oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    context.read<ClassroomsBloc>().add(LoadClassrooms());
  }
}
