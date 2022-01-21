import 'dart:developer';

import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/src/home/bloc/home_bloc.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CalendarItem extends StatelessWidget {
  final Lessons lesson;

  const CalendarItem({Key key, this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mapTypeWithColor = {
      "VIDEO": AntColors.red6,
      "QUIZ": AntColors.gold6,
      "MEETING": AntColors.blue6,
      "ASSIGNMENT": AntColors.purple6,
      "PDF": AntColors.cyan6,
      "ENROLLMENT_STATUS_CHANGE": AntColors.blue6
    };
    return GestureDetector(
      onTap: () {
        // ClassroomRepository classroomRepository = ClassroomRepository(
        //   authenticationRepository:
        //   RepositoryProvider.of<AuthenticationRepository>(
        //       context),
        // );
        // final ClassroomEntity classroom = await classroomRepository.getClassroomById(classroomId);
        context.read<HomeBloc>().add(VirtualClassPageChangedOpenedLesson(
            navigationItem: NavigationItemKey.VIRTUAL_CLASSROOM,
            selectedVirtualClassroomId: lesson.subjectPlanTrees[0].subjectPlan.classroomId,
            lessonId: lesson.id));
      },
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  color: mapTypeWithColor[lesson.lessonType],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Row(
                        children: [
                          lesson.lessonType != null
                              ? TypeItem(
                                  itemType: lesson.lessonType,
                                )
                              : Container(),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              _getBody(),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                               // crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Icon(
                                    RemixIcons.time_line,
                                    color: AntColors.gray6,
                                    size: 16.sp,
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  BaseText(
                                    type: TextTypes.d1,
                                    text: _getDate(),
                                    textColor: AntColors.gray8,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    RemixIcons.door_open_line,
                                    color: AntColors.gray6,
                                    size: 16.sp,
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  BaseText(
                                    type: TextTypes.d1,
                                    textColor: AntColors.gray8,
                                    text: lesson.subjectPlanTrees[0].subjectPlan.name,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),

                            ],
                          )),
                          SizedBox(
                            width: 20.w,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    var date = formatter.format(DateTime.tryParse(lesson.endDate).toLocal()).toString();
    return date;
  }

  _getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          type: TextTypes.d1,
          weightType: FontWeight.w600,
          text: lesson.name,
          textColor: AntColors.gray8,
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
