import 'dart:async';

import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/notifications_repository/lib/notifications_api_provider.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/notifications/view/scenes/all_notifications/view/all_notifications_scene.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/async_classroom_item.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationComponent extends StatefulWidget {
  @override
  _NotificationComponentState createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  StreamController<int> _refreshController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 14.w),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(AllNotifications.route(_reloadNotificationCount,(classroomId, lessonId) async {
            ClassroomRepository classroomRepository = ClassroomRepository(
              authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(
                  context),
            );
            final ClassroomEntity classroom = await classroomRepository.getClassroomById(classroomId);
            if(classroom.isAsync) {
              Navigator.of(context).push(AsyncClassroomItem.route(
                  classroomId, "", lessonId));
            } else {
              context.read<HomeBloc>().add(VirtualClassPageChangedOpenedLesson(
                  navigationItem: NavigationItemKey.VIRTUAL_CLASSROOM,
                  selectedVirtualClassroomId: classroomId,
                  lessonId: lessonId));
            }
          },));
        },
        child: SizedBox(
          width: 32.sp,
          height: 32.sp,
          child: Center(
            child: StreamBuilder<int>(
                stream: _refreshController.stream,
                builder: (context, snapshot) {
                  return Badge(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    position: BadgePosition.topEnd(top: -5, end: -5),
                    animationType: 	BadgeAnimationType.scale,
                    shape: BadgeShape.square,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    badgeColor: AntColors.red6,
                    showBadge: snapshot.data != null && snapshot.data > 0,
                    badgeContent: Center(
                      child: BaseText(
                        align: TextAlign.center,
                        textColor: Colors.white,
                        text: snapshot.hasData ? "${snapshot.data}" : "0",
                        fontSize: 10.sp,
                      ),
                    ),
                    child: Icon(
                      RemixIcons.notification_3_line,
                      color: AntColors.gray6,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  _reloadNotificationCount() async {
    _getNotificationCount();
  }


  @override
  void initState() {
    super.initState();
    _refreshController = new StreamController<int>();
    _getNotificationCount();
  }

  _getNotificationCount() async {
    final authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    NotificationsApiProvider notificationsApiProvider =
        NotificationsApiProvider(authenticationRepository);
    final nr = await notificationsApiProvider.countAllByUserId();
    _refreshController.add(nr > 0 ? nr : 0);
  }
}
