import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/generated/l10n.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/calendar/view/calendar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SingleDayItem extends StatelessWidget {
  final List<Lessons> todayLessons;
  final String date;
  final bool selected;

  const SingleDayItem({Key key, this.todayLessons, this.date, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AntColors.blue1,
            height: 32.h,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BaseText(
                  align: TextAlign.start,
                  text: _getDate(),
                  type: TextTypes.d2,
                  textColor: selected ? AntColors.blue6 : AntColors.gray7,
                ),
              ),
            ),
          ),
          todayLessons.length == 0
              ? Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0.w, top: 14.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Image.asset(
                          "assets/images/empty_calendar/empty_calendar.png",
                          fit: BoxFit.cover,
                          width: 108.w,
                          height: 92.h,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        BaseText(
                          text: s.no_items_today_calendar,
                          type: TextTypes.d2,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final lesson = todayLessons[index];
                    return CalendarItem(
                      lesson: lesson,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 2.h,
                    );
                  },
                  itemCount: todayLessons.length)
        ],
      ),
    );
  }

  _getDate() {
    var formatter = new DateFormat("EEEE, dd MMMM yyyy");

    var date = formatter.format(DateTime.tryParse(this.date)).toString();
    return date.capitalizeFirstOfEach;
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstOfEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}
