import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadedLessonItem extends StatelessWidget {
  final Lessons lesson;
  final bool finished;
  final Function onClick;

  const DownloadedLessonItem(
      {Key key, this.lesson, this.finished, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TypeItem(
              itemType: lesson.lessonType,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseText(
                                text: lesson.classroomName,
                                type: TextTypes.h6,
                                textColor: AntColors.gray8,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: BaseText(
                                        text: lesson.name,
                                        type: TextTypes.d1,
                                        overflow: TextOverflow.ellipsis,
                                        weightType: FontWeight.w400,
                                        textColor: AntColors.gray8,
                                      ),
                                    ),
                                    VerticalDivider(
                                      indent: 2,
                                      endIndent: 2,
                                      color: AntColors.gray8,
                                    ),
                                    BaseText(
                                      text: lesson.fileSize,
                                      type: TextTypes.d1,
                                      weightType: FontWeight.w400,
                                      textColor: AntColors.gray6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        RemixIcons.arrow_right_s_line,
                        size: 24.sp,
                        color: AntColors.gray7,
                      ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Divider(
                    indent: 12.w,
                    height: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TypeItem extends StatelessWidget {
  final mapTypeWithIcon = {
    "VIDEO": RemixIcons.play_fill,
    "QUIZ": RemixIcons.question_fill,
    "MEETING": RemixIcons.live_fill,
    "ASSIGNMENT": RemixIcons.todo_fill,
    "PDF": RemixIcons.slideshow_2_line,
    "ENROLLMENT_STATUS_CHANGE": RemixIcons.door_open_line
  };

  final mapTypeWithBackgroundColors = {
    "VIDEO": AntColors.red1,
    "QUIZ": AntColors.gold1,
    "MEETING": AntColors.blue1,
    "ASSIGNMENT": AntColors.purple1,
    "PDF": AntColors.cyan1,
    "ENROLLMENT_STATUS_CHANGE": AntColors.blue1
  };

  final mapTypeWithColor = {
    "VIDEO": AntColors.red6,
    "QUIZ": AntColors.gold6,
    "MEETING": AntColors.blue6,
    "ASSIGNMENT": AntColors.purple6,
    "PDF": AntColors.cyan6,
    "ENROLLMENT_STATUS_CHANGE": AntColors.blue6
  };

  final String itemType;
  final double size;

  TypeItem({Key key, this.itemType, this.size = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.w,
      backgroundColor: mapTypeWithBackgroundColors[itemType],
      child: Center(
        child: Icon(
          mapTypeWithIcon[itemType],
          color: mapTypeWithColor[itemType],
        ),
      ),
    );
  }
}
