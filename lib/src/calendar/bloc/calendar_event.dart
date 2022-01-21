part of 'calendar_bloc.dart';

class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class LoadCalendarItems extends CalendarEvent {
  final String startDate;
  final String endDate;

  LoadCalendarItems({this.startDate, this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}
