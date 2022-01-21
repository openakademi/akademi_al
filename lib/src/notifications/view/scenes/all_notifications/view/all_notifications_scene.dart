import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/notifications_repository/lib/notifications_api_provider.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/notifications/view/scenes/all_notifications/bloc/all_notifications_bloc.dart';
import 'package:akademi_al_mobile_app/src/notifications/view/scenes/all_notifications/view/components/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({Key key, this.reload, this.reroute}) : super(key: key);

  static Route route(Function reload, Function reroute) {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (context) {
              return AllNotificationsBloc(NotificationsApiProvider(
                  RepositoryProvider.of<AuthenticationRepository>(context)));
            },
            child: AllNotifications(reload: reload, reroute: reroute,)));
  }

  final Function reload;
  final Function reroute;

  @override
  _AllNotificationsState createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: Center(
          child: IconButton(
            onPressed: () {
              widget.reload();
              Navigator.of(context).pop();
            },
            icon: Icon(
              RemixIcons.arrow_left_line,
              color: AntColors.blue6,
              size: 24.sp,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        title: BaseText(
          text: s.all_notifications_title,
          letterSpacing: -0.4,
          lineHeight: 1.21,
        ),
      ),
      body: BlocBuilder<AllNotificationsBloc, AllNotificationsState>(
          builder: (context, state) {
        if (state.loading != null && state.loading || state.loading == null) {
          return SkeletonList();
        } else {
          return state.notifications.length != 0 ?SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                state.notifications
                    .where((element) => !element.markedAsSeen).length > 0 ? Container(
                  height: 40.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.w),
                      child: BaseText(
                        text: s.new_notifications,
                        type: TextTypes.h6,
                        align: TextAlign.start,
                      ),
                    ),
                  ),
                ): Container(),
                Column(
                  children: state.notifications
                      .where((element) => !element.markedAsSeen)
                      .map((e) =>
                      Column(
                        children: [
                          NotificationItem(
                            notification: e,
                            reroute: (classroomId, lessonId) {
                              widget.reroute(classroomId, lessonId);
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            height: 12.h,
                          )
                        ],
                      ))
                      .toList(),
                ),
                Container(
                  height: 40.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.w),
                      child: BaseText(
                        text: s.old_notifications,
                        type: TextTypes.h6,
                        align: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: state.notifications
                      .where((element) => element.markedAsSeen)
                      .map((e) =>
                      NotificationItem(
                        notification: e,
                        reroute: (classroomId, lessonId) {
                          widget.reroute(classroomId, lessonId);
                          Navigator.of(context).pop();
                        },
                      ))
                      .toList(),
                ),
              ],
            ),
          ) : Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty_notifications/empty_notifications.png",
                      fit: BoxFit.cover,
                      width: 130.w,
                      height: 85.h,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    BaseText(
                      align: TextAlign.center,
                      text: s.empty_notification,
                      type: TextTypes.d1,
                      textColor: AntColors.gray8,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  @override
  void initState() {
    context.read<AllNotificationsBloc>().add(LoadAllNotificationsEvent());
    super.initState();
  }
}
