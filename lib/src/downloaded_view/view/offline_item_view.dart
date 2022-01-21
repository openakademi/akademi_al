import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/icons/remix_icons_icons.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/components/lesson_details.dart';
import 'package:akademi_al_mobile_app/src/subjects/async_classroom_item/view/lesson_item.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_content/view/components/video_lesson_header.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/bloc/lesson_item_bloc.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/utils/lesson_item_utils.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/view/component/bottom_lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OfflineItemView extends StatefulWidget {
  static Route route(
      Lessons lesson, Function reload, Function reroute, Function close) {
    return MaterialPageRoute<void>(
      builder: (_) => OfflineItemView(
        lesson: lesson,
        reload: reload,
        reroute: reroute,
        close: close,
      ),
    );
  }

  final Lessons lesson;
  final Function reload;
  final Function reroute;
  final Function close;

  const OfflineItemView(
      {Key key, this.lesson, this.reload, this.reroute, this.close})
      : super(key: key);

  @override
  _OfflineItemViewState createState() => _OfflineItemViewState();
}

class _OfflineItemViewState extends State<OfflineItemView> {
  var correctAnswers = 0;
  LessonItemUtils lessonItemUtils;

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(RemixIcons.arrow_left_line, color: AntColors.blue6),
          onPressed: () => {
            if (widget.close != null) {widget.close()},
            Navigator.of(context).pop()
          },
        ),
        elevation: 1,
        title: Image.asset(
          "assets/logos/akademi_logo/akademi_logo.png",
          width: 94.w,
          height: 24.h,
          fit: BoxFit.fill,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              VideoLessonHeader(lesson: widget.lesson, playOffline: true,),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0.w),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    child: Row(
                      children: [
                        TypeItem(
                          itemType: widget.lesson.lessonType,
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText(
                                  text: widget.lesson.name,
                                  type: TextTypes.h5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w)
                ]),
              ),
              SizedBox(
                height: 24.h,
              ),
              widget.lesson.endDate != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 20.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: s.end_deadline,
                            type: TextTypes.d1,
                            textColor: AntColors.gray7,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          BaseText(
                            text: _getDate(),
                            type: TextTypes.d2,
                            textColor: AntColors.gray7,
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 24.h,
              ),
              Flexible(
                child: LessonDetails(lesson: widget.lesson),
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    lessonItemUtils = LessonItemUtils();
  }

  _getDate() {
    var formatter = new DateFormat("dd.MM.yyyy kk:mm");
    if (widget.lesson.endDate != null) {
      var date =
          formatter.format(DateTime.tryParse(widget.lesson.endDate)).toString();
      return date;
    } else {
      return "";
    }
  }
}
