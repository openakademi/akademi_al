import 'dart:async';

import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc({this.lessonRepository}) : super(CalendarState());

  final LessonRepository lessonRepository;

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if(event is LoadCalendarItems) {
      yield* _mapLoadCalendarItemsToState(event, state);
    }
  }

  Stream<CalendarState> _mapLoadCalendarItemsToState(LoadCalendarItems event, CalendarState state) async* {
    yield state.copyWith(
      loading: true
    );

    List<Lessons> lessons = await lessonRepository.getCalendarLessonsByDateSegmentAndClassroomId(event.startDate.toString(), event.endDate.toString());

    yield state.copyWith(
      loading: false,
      currentMonthLessons: lessons
    );
  }
}
