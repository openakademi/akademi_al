import 'dart:collection';

import 'package:akademi_al_mobile_app/components/colors/ant_colors.dart';
import 'package:akademi_al_mobile_app/components/skeleton_list/skeleton_list.dart';
import 'package:akademi_al_mobile_app/components/text/text.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/calendar/bloc/calendar_bloc.dart';
import 'package:akademi_al_mobile_app/src/notifications/view/scenes/all_notifications/view/components/single_day_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarController _calendarController;
  ScrollController _scrollController;
  Map<DateTime, List> _events;
  DateTime selectedDay;
  Map<DateTime, List> selectedLessons;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: BlocListener<CalendarBloc, CalendarState>(
          listener: (context, state) {
            if (state.currentMonthLessons != null) {
              setState(() {
                final daysWithEvents = groupBy<Lessons, DateTime>(
                    state.currentMonthLessons, (obj) {
                  final date =
                      Jiffy(DateTime.tryParse(obj.endDate), "yyyy-MM-dd")
                          .local();
                  return (Jiffy(date)..startOf(Units.DAY)).dateTime;
                });
                if (!daysWithEvents
                    .containsKey((Jiffy()..startOf(Units.DAY)).dateTime)) {
                  daysWithEvents.putIfAbsent(
                      (Jiffy()..startOf(Units.DAY)).dateTime, () => []);
                }
                _events = SplayTreeMap.from(daysWithEvents);
                final selectedDay = Jiffy(DateTime.now(), "yyyy-MM-dd")
                  ..startOf(Units.DAY);
                if (this.selectedDay == selectedDay.dateTime) {
                  final selectedDay = Jiffy(DateTime.now(), "yyyy-MM-dd")
                    ..startOf(Units.DAY);
                  daysWithEvents
                      .removeWhere((key, value) => key != selectedDay.dateTime);
                  selectedLessons = SplayTreeMap.from(daysWithEvents);
                }
              });
            }
          },
          child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
            return Column(children: [
              TableCalendar(
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.week: 'Week',
                },
                initialCalendarFormat: CalendarFormat.month,
                onCalendarCreated:
                    (DateTime first, DateTime last, CalendarFormat format) {
                  final startDate = Jiffy(first)..startOf(Units.DAY);
                  final endDate = Jiffy(last).local();
                  var formatter = new DateFormat("yyyy-MM-d 00:00");
                  context.read<CalendarBloc>().add(LoadCalendarItems(
                        startDate: formatter
                            .format(
                                startDate.dateTime.subtract(Duration(days: 1)))
                            .toString(),
                        endDate: formatter
                            .format(endDate.add(Duration(days: 1)))
                            .toString(),
                      ));
                },
                onVisibleDaysChanged:
                    (DateTime first, DateTime last, CalendarFormat format) {
                  // final startDate = Jiffy(first)..startOf(Units.DAY);
                  // final endDate = Jiffy(last).local();
                  // var formatter = new DateFormat("yyyy-MM-d 00:00");
                  // context.read<CalendarBloc>().add(LoadCalendarItems(
                  //       startDate: formatter
                  //           .format(
                  //               startDate.dateTime.subtract(Duration(days: 1)))
                  //           .toString(),
                  //       endDate: formatter
                  //           .format(endDate.add(Duration(days: 1)))
                  //           .toString(),
                  //     ));
                  // setState(() {
                  //   // _calendarController.selectedDay = selectedDay;
                  // });
                },
                onDaySelected: (
                  DateTime day,
                  List events,
                  List holidays,
                ) {
                  _onDaySelected(day, events, holidays, state);
                },
                calendarController: _calendarController,
                startingDayOfWeek: StartingDayOfWeek.monday,
                events: _events,
                calendarStyle: CalendarStyle(
                    markersPositionBottom: 0.0,
                    markersMaxAmount: 1,
                    selectedColor: AntColors.blue6,
                    todayColor: Colors.white,
                    markersColor: AntColors.blue6,
                    outsideDaysVisible: false,
                    weekendStyle: defaultTextStyles[TextTypes.p2]
                        .copyWith(color: AntColors.gray8),
                    weekdayStyle: defaultTextStyles[TextTypes.p2]
                        .copyWith(color: AntColors.gray8),
                    highlightToday: true,
                    todayStyle: defaultTextStyles[TextTypes.p2]
                        .copyWith(color: AntColors.blue6)),
                headerStyle: HeaderStyle(
                    centerHeaderTitle: true, formatButtonVisible: false),
              ),
              SizedBox(
                height: 8.h,
              ),
              state.loading != null && !state.loading
                  ? Expanded(
                      child: ListView.separated(
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            final lessons =
                                selectedLessons.values.toList()[index];
                            return SingleDayItem(
                              todayLessons: lessons,
                              date: selectedLessons.keys
                                  .toList()[index]
                                  .toLocal()
                                  .toString(),
                              selected: selectedDay ==
                                  selectedLessons.keys
                                      .toList()[index]
                                      .toLocal(),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 8.h,
                            );
                          },
                          itemCount: selectedLessons.keys.length))
                  : Expanded(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
            ]);
          }),
        ));
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
    _calendarController = CalendarController();
    _events = {};
    selectedLessons = {};
    selectedDay =
        (Jiffy(DateTime.now(), "yyyy-MM-dd").startOf(Units.DAY)).dateTime;
  }

  _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _calendarController.setCalendarFormat(CalendarFormat.week);
      setState(() {});
    }

    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      _calendarController.setCalendarFormat(CalendarFormat.month);
      setState(() {});
    }
  }

  void _onDaySelected(
      DateTime day, List events, List holidays, CalendarState state) {
    setState(() {
      selectedDay = (Jiffy(day, "yyyy-MM-dd")..startOf(Units.DAY)).dateTime;
      if (selectedLessons.containsKey(selectedDay)) {
        final filteredLesson = state.currentMonthLessons.where((element) {
          final endDate =
              Jiffy(DateTime.tryParse(element.endDate), "yyyy-MM-dd").local();
          return endDate.isAfter(selectedDay) ||
              endDate.isSameDate(selectedDay);
        });
        final daysWithEvents =
            groupBy<Lessons, DateTime>(filteredLesson, (obj) {
          final date =
              Jiffy(DateTime.tryParse(obj.endDate), "yyyy-MM-dd").local();
          return (Jiffy(date)..startOf(Units.DAY)).dateTime;
        });
        daysWithEvents.removeWhere((key, value) => key != selectedDay);
        selectedLessons = SplayTreeMap.from(daysWithEvents);
      } else {
        final filteredLesson = state.currentMonthLessons.where((element) {
          final endDate =
              Jiffy(DateTime.tryParse(element.endDate), "yyyy-MM-dd").local();
          return endDate.isAfter(selectedDay) ||
              endDate.isSameDate(selectedDay);
        });
        final daysWithEvents =
            groupBy<Lessons, DateTime>(filteredLesson, (obj) {
          final date =
              Jiffy(DateTime.tryParse(obj.endDate), "yyyy-MM-dd").local();
          return (Jiffy(date)..startOf(Units.DAY)).dateTime;
        });
        daysWithEvents.removeWhere((key, value) => key != selectedDay);

        daysWithEvents.putIfAbsent(selectedDay, () => <Lessons>[]);
        selectedLessons = SplayTreeMap.from(daysWithEvents);
      }
    });
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
