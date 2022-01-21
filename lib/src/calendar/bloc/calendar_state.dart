part of 'calendar_bloc.dart';


class CalendarState extends Equatable {
  const CalendarState({this.currentMonthLessons, this.loading});

  final List<Lessons> currentMonthLessons;
  final bool loading;

  CalendarState copyWith({
    List<Lessons> currentMonthLessons,
    bool loading,
  }) {
    return new CalendarState(
      currentMonthLessons: currentMonthLessons ?? this.currentMonthLessons,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [currentMonthLessons, loading];
}
