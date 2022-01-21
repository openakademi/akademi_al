import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/downloader/downloader.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonItem extends StatelessWidget {
  final Lessons lesson;
  final bool finished;
  final bool isSelected;
  final Function onClick;
  final Function onFinish;

  const LessonItem(
      {Key key,
      this.lesson,
      this.finished,
      this.isSelected,
      this.onClick,
      this.onFinish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        color: this.isSelected != null && this.isSelected
            ? AntColors.blue1
            : Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0.w, top: 16.h, bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TypeItem(
                itemType: lesson.lessonType,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0.w),
                  child: BaseText(
                    text: lesson.name,
                    type: TextTypes.d1,
                    weightType: this.isSelected != null && this.isSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
                    textColor: this.isSelected != null && this.isSelected
                        ? AntColors.blue6
                        : AntColors.gray8,
                  ),
                ),
              ),
              finished
                  ? Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Icon(
                        RemixIcons.checkbox_circle_fill,
                        size: 16.sp,
                        color: AntColors.green6,
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
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
