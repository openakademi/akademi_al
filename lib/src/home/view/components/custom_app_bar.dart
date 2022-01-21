import 'package:akademi_al_mobile_app/components/button/lib/main_text_button.dart';
import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/notifications/view/notification_components.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_subjects/view/subjects_scene.dart';
import 'package:akademi_al_mobile_app/src/user_config/view/main_user_avatar.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/bloc/virtual_classroom_content_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_home/bloc/virtual_classroom_home_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_homework/bloc/virtual_classroom_homework_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/virtual_classroom.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/virtual_classroom_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home_page.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final GlobalKey<SubjectsSceneState> subjectKey;
  final GlobalKey<MainUserAvatarState> avatarKey;
  final GlobalKey<VirtualClassroomSceneState> virtualClassroomKey;
  final bool offline;

  const CustomAppBar(
      {Key key,
      this.subjectKey,
      this.avatarKey,
      this.virtualClassroomKey,
      this.offline})
      : super(key: key);

  @override
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {
  GlobalKey<VirtualClassroomSceneState> virtualClassroomKey;
  final EnrollmentEntity enrollment;

  CustomAppBarState({this.enrollment});

  @override
  void initState() {
    super.initState();
    virtualClassroomKey = widget.virtualClassroomKey;
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    final pageToTitle = {
      NavigationItemKey.HOME: Image.asset(
        "assets/logos/akademi_logo/akademi_logo.png",
        width: 94.sp,
        height: 24.sp,
        fit: BoxFit.fill,
      ),
      NavigationItemKey.VIRTUAL_CLASSROOM: InkWell(
          onTap: () {
            context.read<HomeBloc>().add(
                NavigationItemChanged(NavigationItemKey.HOME, "", enrollment));
          },
          child: Image.asset(
            "assets/logos/akademi_logo/akademi_logo.png",
            width: 94.sp,
            height: 24.sp,
            fit: BoxFit.fill,
          )),
      NavigationItemKey.SETTINGS: InkWell(
          onTap: () {
            context.read<HomeBloc>().add(
                NavigationItemChanged(NavigationItemKey.HOME, "", enrollment));
          },
          child: Image.asset(
            "assets/logos/akademi_logo/akademi_logo.png",
            width: 94.sp,
            height: 24.sp,
            fit: BoxFit.fill,
          )),
      NavigationItemKey.SUBJECTS: BaseText(
        text: s.subjects,
        letterSpacing: -0.4,
        weightType: FontWeight.w600,
        lineHeight: 1.21,
      ),
      NavigationItemKey.CALENDAR: BaseText(
        text: s.calendar_title,
        letterSpacing: -0.4,
        weightType: FontWeight.w600,
        lineHeight: 1.21,
      ),
      NavigationItemKey.CLASSROOMS: InkWell(
          onTap: () {
            context.read<HomeBloc>().add(
                NavigationItemChanged(NavigationItemKey.HOME, "", enrollment));
          },
          child: Image.asset(
            "assets/logos/akademi_logo/akademi_logo.png",
            width: 94.sp,
            height: 24.sp,
            fit: BoxFit.fill,
          )),
      NavigationItemKey.USER_PROFILE: BaseText(
        text: s.my_profile_title,
        letterSpacing: -0.4,
        weightType: FontWeight.w600,
        lineHeight: 1.21,
      ),
      NavigationItemKey.DOWNLOADED: BaseText(
        text: s.downloaded,
        letterSpacing: -0.4,
        weightType: FontWeight.w600,
        lineHeight: 1.21,
      ),
    };

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return AppBar(
        elevation: state.currentNavigationItem.index ==
                    NavigationItemKey.DOWNLOADED.index ||
                state.currentNavigationItem.index ==
                    NavigationItemKey.CALENDAR.index
            ? 1
            : 0,
        title: pageToTitle[state.currentNavigationItem],
        actions: _getActions(state, state.currentNavigationItem, s),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              RemixIcons.menu_2_line,
              size: 24.sp,
              color: AntColors.blue6,
            ),
            onPressed: () => {
              context.read<HomeBloc>().add(DrawerOpenedFirstTime()),
              Scaffold.of(context).openDrawer()
            },
          );
        }),
        centerTitle: true,
      );
    });
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  _getActions(state, NavigationItemKey key, S s) {
    if (NavigationItemKey.VIRTUAL_CLASSROOM.index == key.index) {
      if (state.virtualClassroomPageIndex == 0) {
        return <Widget>[
          IconButton(
              icon: Icon(
                RemixIcons.more_fill,
                color: AntColors.gray8,
              ),
              onPressed: () {
                var ancestralState =
                    context.findAncestorStateOfType<HomePageState>();
                if (ancestralState.openedClassroomKey?.currentState != null) {
                  ancestralState.openedClassroomKey?.currentState
                      ?.showHomePageActionModal();
                }
              })
        ];
      } else if (state.virtualClassroomPageIndex == 1) {
        return <Widget>[
          IconButton(
              icon: Icon(
                RemixIcons.filter_3_line,
                color: AntColors.gray8,
              ),
              onPressed: () {
                var ancestralState =
                    context.findAncestorStateOfType<HomePageState>();

                if (ancestralState.openedClassroomKey?.currentState != null) {
                  ancestralState.openedClassroomKey?.currentState
                      ?.showContentActionModal();
                }
              })
        ];
      } else if (state.virtualClassroomPageIndex == 3) {
        return <Widget>[
          IconButton(
              icon: Icon(
                RemixIcons.filter_3_line,
                color: AntColors.gray8,
              ),
              onPressed: () {
                var ancestralState =
                    context.findAncestorStateOfType<HomePageState>();

                if (ancestralState.openedClassroomKey?.currentState != null) {
                  ancestralState.openedClassroomKey?.currentState
                      ?.showHomeworkActionModal();
                }
              })
        ];
      }
    } else {
      final actions = {
        NavigationItemKey.HOME: <Widget>[],
        NavigationItemKey.SETTINGS: <Widget>[],
        NavigationItemKey.SUBJECTS: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16.0.w),
            child: MainTextButton(
              text: s.filter,
              onPress: () {
                widget.subjectKey.currentState.showFilterBottomSheet();
              },
            ),
          )
        ],
        NavigationItemKey.CALENDAR: <Widget>[],
        NavigationItemKey.CLASSROOMS: <Widget>[],
        NavigationItemKey.DOWNLOADED:
            widget.offline ? <Widget>[Container()] : [],
        NavigationItemKey.USER_PROFILE: <Widget>[Container()]
      };

      if (actions[key].length == 0) {
        return [
          NotificationComponent(),
          Container(
            child: Center(
              child: MainUserAvatar(
                width: 32.sp,
                height: 32.sp,
                key: widget.avatarKey,
              ),
            ),
          ),
        ];
      }
      return actions[key];
    }
  }
}
