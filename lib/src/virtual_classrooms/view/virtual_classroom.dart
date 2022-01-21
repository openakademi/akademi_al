import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/bloc/virtual_classroom_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/view/lesson_item_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../virtual_classroom_utils.dart';
import 'scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'scenes/virtual_classroom_content/view/virtual_classroom_content.dart';
import 'scenes/virtual_classroom_home/bloc/virtual_classroom_home_bloc.dart';
import 'scenes/virtual_classroom_home/view/virtual_classroom_home.dart';
import 'scenes/virtual_classroom_homework/bloc/virtual_classroom_homework_bloc.dart';
import 'scenes/virtual_classroom_homework/view/virtual_classroom_homework.dart';
import 'scenes/virtual_classroom_pupils/view/virtual_classroom_pupils.dart';

class VirtualClassroomScene extends StatefulWidget {
  const VirtualClassroomScene(
      {Key key,
      this.classroomId,
      this.enrollmentEntity,
      this.testActions,
      this.lessonId})
      : super(key: key);

  final String classroomId;
  final EnrollmentEntity enrollmentEntity;
  final Function testActions;
  final String lessonId;

  @override
  VirtualClassroomSceneState createState() => VirtualClassroomSceneState();
}

class VirtualClassroomSceneState extends State<VirtualClassroomScene> {
  String classroomId;
  GlobalKey homeKey;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return BlocListener<VirtualClassroomBloc, VirtualClassroomState>(
      listenWhen: (previus, next) {
        return previus.currentlyOpenedLesson != next.currentlyOpenedLesson;
      },
      listener: (context, state) {
        if (state.currentlyOpenedLesson != null &&
            state.currentlyOpenedLesson.isNotEmpty) {
          final lesson = state.lessonsGroupedByWeek.values
              .expand((element) => element)
              .firstWhere(
                  (element) => element.id == state.currentlyOpenedLesson,
                  orElse: () => null);
          Navigator.of(context)
              .push(LessonItemScene.route(lesson, state.enrollmentEntity, () {
            context
                .read<VirtualClassroomBloc>()
                .add(ReloadSubjectPlanTreeEvent());
          }, () {
            context
                .read<VirtualClassroomBloc>()
                .add(ReloadSubjectPlanTreeEvent());
            context.read<VirtualClassroomBloc>().add(NextLessonEvent());
          }, () {
            context
                .read<VirtualClassroomBloc>()
                .add(ReloadSubjectPlanTreeEvent());
            context.read<VirtualClassroomBloc>().add(LessonChangedEvent(""));
          }, state.classroomEntity));
        }
      },
      child: BlocBuilder<VirtualClassroomBloc, VirtualClassroomState>(
          builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: state.selectedVirtualClassroomId != null
              ? _getBody(state)
              : Container(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.virtualClassroomPageIndex,
            backgroundColor: AntColors.blue1,
            selectedItemColor: AntColors.blue6,
            unselectedItemColor: AntColors.gray8,
            elevation: 6,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedFontSize: 11.sp,
            unselectedFontSize: 11.sp,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if (state.loading != null && state.loading) {
              } else {
                context
                    .read<VirtualClassroomBloc>()
                    .add(VirtualClassroomPageChanged(index));
                context.read<HomeBloc>().add(VirtualClassPageChanged(index));
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  RemixIcons.chat_4_line,
                  color: AntColors.gray8,
                  size: 24.sp,
                ),
                activeIcon: Icon(
                  RemixIcons.chat_4_line,
                  color: AntColors.blue6,
                  size: 24.sp,
                ),
                label: s.virtual_classroom_home,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  RemixIcons.file_list_line,
                  color: AntColors.gray8,
                  size: 24.sp,
                ),
                activeIcon: Icon(
                  RemixIcons.file_list_line,
                  color: AntColors.blue6,
                  size: 24.sp,
                ),
                label: s.virtual_classroom_content,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  RemixIcons.team_line,
                  color: AntColors.gray8,
                  size: 24.sp,
                ),
                activeIcon: Icon(
                  RemixIcons.team_line,
                  color: AntColors.blue6,
                  size: 24.sp,
                ),
                label: s.virtual_classroom_people,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  RemixIcons.todo_line,
                  color: AntColors.gray8,
                  size: 24.sp,
                ),
                activeIcon: Icon(
                  RemixIcons.todo_line,
                  color: AntColors.blue6,
                  size: 24.sp,
                ),
                label: s.virtual_classroom_homework,
              ),
            ],
          ),
        );
      }),
    );
  }

  _getBody(VirtualClassroomState state) {
    if (state.loading != null && state.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (state.virtualClassroomPageIndex == 0) {
        if (homeKey == null) {
          homeKey = GlobalKey();
        }
        return VirtualClassroomHome(
            key: homeKey,
            classroomEntity: state.classroomEntity,
            enrollmentEntity: state.enrollmentEntity);
      } else if (state.virtualClassroomPageIndex == 1) {
        return VirtualClassroomContent(
          classroomEntity: state.classroomEntity,
          enrollmentEntity: widget.enrollmentEntity,
          lessonId: state.lessonToOpen,
          tags: state.tags,
        );
      } else if (state.virtualClassroomPageIndex == 2) {
        return VirtualClassroomPupils(
          pupils: state.pupils,
          teacher: context
              .read<VirtualClassroomHomeBloc>()
              .state
              .classroomEntity
              .userCreatedBy,
          teacherId: context
              .read<VirtualClassroomHomeBloc>()
              .state
              .classroomEntity
              .createdBy,
        );
      } else if (state.virtualClassroomPageIndex == 3) {
        return VirtualClassroomHomework(
          classroomId:
              context.read<VirtualClassroomHomeBloc>().state.classroomEntity.id,
          subjectPlanId: context
              .read<VirtualClassroomHomeBloc>()
              .state
              .classroomEntity
              .subjectPlan
              .id,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    classroomId = widget.classroomId;
    print("init state lessonid ${widget.lessonId}");
    context.read<VirtualClassroomBloc>().add(VirtualClassroomOpened(
        widget.classroomId,
        widget.enrollmentEntity,
        widget.lessonId.isEmpty ? null : widget.lessonId));
  }

  @override
  void dispose() {
    super.dispose();
  }

  showHomePageActionModal() {
    final virtualClassroomBloc =
        // ignore: close_sinks
        context.read<VirtualClassroomHomeBloc>();
    if (virtualClassroomBloc.state.loading != null &&
        !virtualClassroomBloc.state.loading) {
      VirtualClassroomUtils().showClassroomDetails(
          context, virtualClassroomBloc.state.classroomEntity);
    }
  }

  showContentActionModal() {
    final virtualClassromContentBloc =
        context.read<VirtualClassroomContentBloc>();

    if (virtualClassromContentBloc.state.loading != null &&
        !virtualClassromContentBloc.state.loading) {
      VirtualClassroomUtils().showFilterWeeksBottomSheet(
          context, virtualClassromContentBloc.state);
    }
  }

  showHomeworkActionModal() {
    final virtualClassromContentBloc =
        context.read<VirtualClassroomHomeworkBloc>();

    if (virtualClassromContentBloc.state.loading != null &&
        !virtualClassromContentBloc.state.loading) {
      VirtualClassroomUtils().showFilterHomeworkBottomSheet(
          context, virtualClassromContentBloc.state);
    }
  }
}
