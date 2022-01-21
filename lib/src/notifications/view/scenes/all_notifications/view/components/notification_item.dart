import 'dart:developer';

import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/components/user_avatar/user_avatar.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/notification.dart'
    as NotificationModel;
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel.Notification notification;
  final Function reroute;


  const NotificationItem({Key key, this.notification, this.reroute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isComment = notification.type != null;
    var supportedTypes = ["VIDEO",
      "QUIZ",
      "MEETING",
      "ASSIGNMENT",
      "PDF",];

    return GestureDetector(
      onTap: () async {
        if(supportedTypes.contains(notification.type)) {
          LessonRepository lessonRepository = LessonRepository(
              authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(
                  context));
          final id = notification.navigateUrl.split("/").last;
          final lesson = await lessonRepository.getLessonById(id);
          reroute(lesson.subjectPlanTrees[0].subjectPlan.classroomId,lesson.id );
        }
      },
      child: Container(
        color: notification.markedAsSeen ? Colors.white : AntColors.blue1,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Row(
            children: [
              Center(
                  child: notification.type != null
                      ? TypeItem(
                          itemType: notification.type,
                        )
                      : UserAvatar(
                          userId: notification.userId,
                        )),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: isComment
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          _getBody(),
                          SizedBox(
                            height: 4.h,
                          ),
                          BaseText(
                            type: TextTypes.d1,
                            textColor: AntColors.gray8,
                            text: notification.message,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          BaseText(
                            type: TextTypes.d2,
                            text: _getDate(),
                            textColor: AntColors.gray7,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          notification.markedAsSeen
                              ? Divider(
                                  height: 1,
                                )
                              : Container()
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            _getBody(),
                            BaseText(
                              type: TextTypes.d2,
                              text: _getDate(),
                              textColor: AntColors.gray7,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            notification.markedAsSeen
                                ? Divider(
                                    height: 1,
                                  )
                                : Container()
                          ]),
              ),
              SizedBox(
                width: 20.w,
              )
            ],
          ),
        ),
      ),
    );
  }

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    var date =
        formatter.format(DateTime.tryParse(notification.createdAt).toLocal()).toString();
    return date;
  }

  _getBody() {
    if (notification.type == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            type: TextTypes.d1,
            weightType: FontWeight.w600,
            text: notification.title,
            textColor: AntColors.gray8,
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            type: TextTypes.d1,
            weightType: FontWeight.w600,
            text: notification.title,
            textColor: AntColors.gray8,
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      );
    }
  }
}
