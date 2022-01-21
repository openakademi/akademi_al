import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/classrooms/bloc/classrooms_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/bloc/virtual_classroom_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/join_classroom.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_details.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/bloc/virtual_classroom_home_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_homework/bloc/virtual_classroom_homework_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_homework/view/scenes/homework_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'view/scenes/virtual_classroom_content/view/scenes/week_filter.dart';

class VirtualClassroomUtils {

  showFilterBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        elevation: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        backgroundColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        barrierColor: Color.fromRGBO(22, 24, 35, 0.4),
        builder: (BuildContext builder) {
          return JoinClassroom(
            navigate: () {
              try {
                context.read<ClassroomsBloc>().add(LoadClassrooms());
              } catch(e) {
                print("e $e");
              }
              context
                  .read<HomeBloc>()
                  .add(NavigationItemChanged(NavigationItemKey.CLASSROOMS, "", null));
            }
          );
        });
  }

  showClassroomDetails(BuildContext context, ClassroomEntity classroomEntity) {


    showCupertinoModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        elevation: 40,
        barrierColor: Color.fromRGBO(22, 24, 35, 0.4),
        backgroundColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return VirtualClassroomDetails(
              classroomEntity: classroomEntity,
              unregisterFunction: () {
                context.read<VirtualClassroomHomeBloc>().add(Unregister());
                context.read<HomeBloc>().add(
                    NavigationItemChanged(NavigationItemKey.CLASSROOMS, null, null));
              });
        });
  }

  showFilterWeeksBottomSheet(
      BuildContext context, VirtualClassroomContentState state) {
    showCupertinoModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        elevation: 40,
        barrierColor: Color.fromRGBO(22, 24, 35, 0.4),
        backgroundColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return WeekFilter(
            key: GlobalKey(),
            state: state,
            addFilters: (List<String> weeks) {
              context.read<VirtualClassroomContentBloc>().add(AddFilter(weeks));
            },
          );
        });
  }

  showFilterHomeworkBottomSheet(
      BuildContext context, VirtualClassroomHomeworkState state) {
    showCupertinoModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        elevation: 40,
        barrierColor: Color.fromRGBO(22, 24, 35, 0.4),
        backgroundColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        builder: (BuildContext builder) {
          return HomeworkFilter(
            key: GlobalKey(),
            state: state,
            addFilters: (List<String> weeks) {
              context.read<VirtualClassroomHomeworkBloc>().add(ChangedFilters(filters: weeks));
            },
          );
        });
  }
}
